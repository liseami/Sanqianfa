import SwiftUI

// 设置项分组
struct ProfileSettingGroup: Identifiable {
    let id = UUID()
    let title: String?
    let items: [ProfileSettingItem]
}

// 设置项
struct ProfileSettingItem: Identifiable {
    let id = UUID()
    let title: String
    let rightText: String?
    let icon: String?
    let showArrow: Bool
    let hasToggle: Bool
    var isToggleOn: Bool = false
    var action: (() -> Void)?
} 