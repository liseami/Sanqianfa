import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var settingGroups: [ProfileSettingGroup] = []
    
    init() {
        setupSettingGroups()
    }
    
    private func setupSettingGroups() {
        settingGroups = [
            // 用户信息组
            ProfileSettingGroup(title: "", items: [
                ProfileSettingItem(
                    title: "个人资料",
                    rightText: nil,
                    icon: "person.circle",
                    showArrow: true,
                    hasToggle: false,
                    action: { print("个人资料") }
                ),
                ProfileSettingItem(
                    title: "订阅会员",
                    rightText: "未订阅",
                    icon: "crown",
                    showArrow: true,
                    hasToggle: false,
                    action: { print("订阅会员") }
                )
            ]),
            
            // 功能设置组
            ProfileSettingGroup(title: "功能设置", items: [
                ProfileSettingItem(
                    title: "离线下载",
                    rightText: nil,
                    icon: "arrow.down.circle",
                    showArrow: false,
                    hasToggle: true,
                    isToggleOn: true
                ),
                ProfileSettingItem(
                    title: "自动播放",
                    rightText: nil,
                    icon: "play.circle",
                    showArrow: false,
                    hasToggle: true,
                    isToggleOn: false
                ),
                ProfileSettingItem(
                    title: "清除缓存",
                    rightText: "23.5MB",
                    icon: "trash",
                    showArrow: true,
                    hasToggle: false
                )
            ]),
            
            // 通知设置组
            ProfileSettingGroup(title: "通知设置", items: [
                ProfileSettingItem(
                    title: "推送通知",
                    rightText: nil,
                    icon: "bell",
                    showArrow: false,
                    hasToggle: true,
                    isToggleOn: false
                ),
                ProfileSettingItem(
                    title: "学习提醒",
                    rightText: nil,
                    icon: "clock",
                    showArrow: false,
                    hasToggle: true,
                    isToggleOn: true
                ),
                ProfileSettingItem(
                    title: "每日一卦",
                    rightText: nil,
                    icon: "sun.max",
                    showArrow: false,
                    hasToggle: true,
                    isToggleOn: true
                )
            ]),
            
            // 隐私安全组
            ProfileSettingGroup(title: "隐私安全", items: [
                ProfileSettingItem(
                    title: "指纹解锁",
                    rightText: nil,
                    icon: "touchid",
                    showArrow: false,
                    hasToggle: true,
                    isToggleOn: false
                ),
                ProfileSettingItem(
                    title: "隐私设置",
                    rightText: nil,
                    icon: "lock",
                    showArrow: true,
                    hasToggle: false
                ),
                ProfileSettingItem(
                    title: "数据备份",
                    rightText: "从不",
                    icon: "icloud",
                    showArrow: true,
                    hasToggle: false
                )
            ]),
            
            // 其他设置组
            ProfileSettingGroup(title: "其他", items: [
                ProfileSettingItem(
                    title: "关于我们",
                    rightText: nil,
                    icon: "info.circle",
                    showArrow: true,
                    hasToggle: false
                ),
                ProfileSettingItem(
                    title: "隐私政策",
                    rightText: nil,
                    icon: "doc.text",
                    showArrow: true,
                    hasToggle: false
                ),
                ProfileSettingItem(
                    title: "用户协议",
                    rightText: nil,
                    icon: "doc.plaintext",
                    showArrow: true,
                    hasToggle: false
                ),
                ProfileSettingItem(
                    title: "评分鼓励",
                    rightText: nil,
                    icon: "star",
                    showArrow: true,
                    hasToggle: false
                ),
                ProfileSettingItem(
                    title: "分享给好友",
                    rightText: nil,
                    icon: "square.and.arrow.up",
                    showArrow: true,
                    hasToggle: false
                )
            ])
        ]
    }
} 
