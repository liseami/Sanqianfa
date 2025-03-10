//
//  SanqianStoreView.swift
//  Sanqianfa
//
//  Created by 赵翔宇 on 2025/3/10.
//

import _StoreKit_SwiftUI
import StoreKit
import SwiftUI

struct SanqianStoreView: View {
    @StateObject var vm: StoreManager = .init(productIds: [
        "com.sanqianfa.month.1","com.sanqianfa.year.1",
        "com.sanqianfa.coinstyle.1",
        "com.sanqianfa.coin",
    ])
    @State private var showingRestoreAlert = false
    @State private var restoreMessage = ""
    
    var body: some View {
        List {
            // 当前用户订阅状态
            Section("当前订阅状态") {
                HStack {
                    Text("当前会员类型")
                    Spacer()
                    Text(vm.appServerLvl.rawValue)
                }
                
                if vm.isPurchasing {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                if let error = vm.purchaseError {
                    Text(errorMessage(for: error))
                        .foregroundColor(.red)
                }
                
                Button("恢复购买") {
                    Task {
                        await vm.restorePurchases()
                        showingRestoreAlert = true
                        restoreMessage = "购买已恢复"
                    }
                }
            }
            
            Section("当前金币数量") {
                HStack {
                    Text("CoinNumber")
                    Spacer()
                    Text("\(vm.currentCoinNumber)")
                }
            }
            
            // 已购买的订阅
            if !vm.purchasedSubscriptions.isEmpty {
                Section("当前订阅") {
                    ForEach(vm.purchasedSubscriptions) { product in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(product.displayName)
                                    .font(.headline)
                                Text(product.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text(subscriptionBadgeText(for: product))
                                .foregroundColor(.green)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                }
            }
            
            // 已购买的非消耗品
            if !vm.purchasedNonConsumables.isEmpty {
                Section("已购买的产品") {
                    ForEach(vm.purchasedNonConsumables) { product in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(product.displayName)
                                    .font(.headline)
                                Text(product.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text("已购买")
                                .foregroundColor(.green)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                }
            }
            
            // 可购买的订阅
            if !vm.subscriptions.isEmpty {
                Section("会员订阅") {
                    ForEach(vm.subscriptions) { product in
                        ProductRow(product: product, isPurchased: vm.isPurchased(product), badgeText: subscriptionBadgeText(for: product)) {
                            Task {
                                await vm.purchase(product)
                            }
                        }
                    }
                }
            }
            
            // 可购买的一次性产品
            if !vm.nonConsumableProducts.isEmpty {
                Section("一次性购买") {
                    ForEach(vm.nonConsumableProducts) { product in
                        ProductRow(product: product, isPurchased: vm.isPurchased(product), badgeText: "已购买") {
                            Task {
                                await vm.purchase(product)
                            }
                        }
                    }
                }
            }

            // 可消耗产品
            if !vm.consumableProducts.isEmpty {
                Section("金币") {
                    ForEach(vm.consumableProducts) { product in
                        ProductRow(product: product, isPurchased: false, badgeText: "购买") {
                            Task {
                                await vm.purchase(product)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("商店")
        .alert("恢复购买", isPresented: $showingRestoreAlert) {
            Button("确定", role: .cancel) {}
        } message: {
            Text(restoreMessage)
        }
    }
    
    // 获取订阅产品的徽章文本
    private func subscriptionBadgeText(for product: Product) -> String {
        if product.id == "com.sanqianfa.month.1" {
            return "月度会员"
        } else if product.id == "com.sanqianfa.year.1" {
            return "年度会员"
        } else {
            return "已订阅"
        }
    }
    
    // 获取错误信息
    private func errorMessage(for error: StoreError) -> String {
        switch error {
        case .failedVerification:
            return "验证失败"
        case .productRequestFailed:
            return "产品请求失败"
        case .purchaseFailed:
            return "购买失败"
        case .userCancelled:
            return "用户取消"
        case .networkError:
            return "网络错误"
        }
    }
}

// 自定义产品行视图
struct ProductRow: View {
    let product: Product
    let isPurchased: Bool
    let badgeText: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(product.displayName)
                    .font(.headline)
                Text(product.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if isPurchased {
                Text(badgeText)
                    .foregroundColor(.green)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(8)
            } else {
                Button(action: action) {
                    Text(product.displayPrice)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    SanqianStoreView()
}
