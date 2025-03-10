import Combine
import Foundation
import StoreKit

typealias Transaction = StoreKit.Transaction

public enum StoreError: Error {
    case failedVerification
    case productRequestFailed
    case purchaseFailed
    case userCancelled
    case networkError
}

public enum AppServerLvl: String {
    case idel = "普通用户"
    case month = "月度会员"
    case year = "年度会员"
}


// 根据我的storekit 配置，写一个 storekit2 框架的 storemangger管理我的IAP购买项目

class StoreManager: ObservableObject {
    // 产品分类
    @Published private(set) var consumableProducts: [Product] = []
    @Published private(set) var nonConsumableProducts: [Product] = []
    @Published private(set) var subscriptions: [Product] = []
    
    // 已购买产品状态
    @Published private(set) var purchasedNonConsumables: [Product] = []
    @Published private(set) var purchasedSubscriptions: [Product] = []
    
    // 购买状态
    @Published private(set) var isPurchasing = false
    @Published private(set) var purchaseError: StoreError?
    @Published var currentCoinNumber: Int = 0
    // 当前用户的服务权限
    
    @Published var appServerLvl: AppServerLvl = .idel
    // 交易监听任务
    var updateListenerTask: Task<Void, Error>?
    
    // 产品ID列表
    private let productIds: [String]
    
    init(productIds: [String]) {
        self.productIds = productIds
        
        // 启动交易监听器
        updateListenerTask = listenForTransactions()
        
        Task {
            // 请求产品信息
            await requestProducts()
            
            // 更新用户产品状态
            await updateCustomerProductStatus()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    // MARK: - 交易监听

    // 防止掉签
    private func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    // 更新用户产品状态
                    await self.updateCustomerProductStatus()
                    // 完成交易
                    await transaction.finish()
                } catch {
                    print("交易验证失败: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - 产品请求
    
    @MainActor
    func requestProducts() async {
        do {
            let storeProducts = try await Product.products(for: productIds)
            
            var newConsumables: [Product] = []
            var newNonConsumables: [Product] = []
            var newSubscriptions: [Product] = []
            
            // 根据类型分类产品
            for product in storeProducts {
                switch product.type {
                case .consumable:
                    newConsumables.append(product)
                case .nonConsumable:
                    newNonConsumables.append(product)
                case .autoRenewable:
                    newSubscriptions.append(product)
                default:
                    print("未知产品类型: \(product.id)")
                }
            }
            
            // 按价格排序
            consumableProducts = sortByPrice(newConsumables)
            nonConsumableProducts = sortByPrice(newNonConsumables)
            subscriptions = sortByPrice(newSubscriptions)
        } catch {
            print("产品请求失败: \(error.localizedDescription)")
            purchaseError = .productRequestFailed
        }
    }
    
    // MARK: - 购买流程
    
    @MainActor
    // 传入产品结构体，调用购买方法
    func purchase(_ product: Product) async {
        isPurchasing = true
        purchaseError = nil
        
        do {
            let result = try await product.purchase()
            
            switch result {
            case .success(let verification):
                print("购买成功")
             
                let transaction = try checkVerified(verification)
                
//                if transaction.productType == .consumable {
//                    self.currentCoinNumber = self.currentCoinNumber + 1
//                }
//                // 更新用户产品状态
                await updateCustomerProductStatus()
                
                // 完成交易
                await transaction.finish()
                
            case .userCancelled:
                print("购买被用户取消")
                purchaseError = .userCancelled
                
            //
            case .pending:
                print("购买待处理，等待进一步处理")
            
            default:
                purchaseError = .purchaseFailed
            }
        } catch {
            print("购买失败: \(error.localizedDescription)")
            purchaseError = .purchaseFailed
        }
        
        isPurchasing = false
    }
    
    // MARK: - 恢复购买
    
    @MainActor
    func restorePurchases() async {
        isPurchasing = true
        purchaseError = nil
        
        do {
            try await AppStore.sync()
            await updateCustomerProductStatus()
        } catch {
            print("恢复购买失败: \(error.localizedDescription)")
            purchaseError = .networkError
        }
        
        isPurchasing = false
    }
    
    // MARK: - 用户产品状态更新
    
    @MainActor
    func updateCustomerProductStatus() async {
        // 先设置一些空数组，和初始会员等级
        // 空数组用来临时存放用户已验证的购买的产品
        var purchasedNonConsumables: [Product] = []
        var purchasedSubscriptions: [Product] = []
        var lvl: AppServerLvl = .idel
        
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                print(transaction.productType)
                switch transaction.productType {
                // 消耗品
//                case .consumable:
////                    if let product = consumableProducts.first(where: { $0.id == transaction.productID }) {
////                        print("检测到可消耗产品购买")
//////                        purchasedConsumables.append(product)
////                    }
//                    break
                // 非消耗品
                case .nonConsumable:
                    if let product = nonConsumableProducts.first(where: { $0.id == transaction.productID }) {
                        purchasedNonConsumables.append(product)
                    }
                // 自动续期定语
                case .autoRenewable:
                    if let product = subscriptions.first(where: { $0.id == transaction.productID }) {
                        purchasedSubscriptions.append(product)
                        print(product.id)
                        if product.id == "com.sanqianfa.month.1", appServerLvl != .year {
                            lvl = .month
                        } else {
                            lvl = .year
                        }
                    }
                    
                default:
                    break
                }
            } catch {
                print("交易验证失败: \(error.localizedDescription)")
            }
        }
        
        // 更新状态
        self.purchasedNonConsumables = purchasedNonConsumables
        self.purchasedSubscriptions = purchasedSubscriptions
        appServerLvl = lvl
    }
    
    // MARK: - 辅助方法
    
    // 验证购买的交易
    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
    
    private func sortByPrice(_ products: [Product]) -> [Product] {
        products.sorted(by: { $0.price < $1.price })
    }
    
    func isPurchased(_ product: Product) -> Bool {
        switch product.type {
        case .nonConsumable:
            return purchasedNonConsumables.contains(product)
        case .autoRenewable:
            return purchasedSubscriptions.contains(product)
        default:
            return false
        }
    }
    
    // MARK: - 订阅权限管理
    
//    // 检查用户是否有特定级别的权限
//    func hasEntitlement(_ level: ServiceEntitlement) -> Bool {
//        return currentEntitlement >= level
//    }
//
//    // 获取产品对应的权限等级
//    func entitlement(for product: Product) -> ServiceEntitlement? {
//        return ServiceEntitlement(for: product.id)
//    }
}
