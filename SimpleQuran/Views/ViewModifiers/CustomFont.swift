//
//  CustomFont.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 17/10/23.
//

import SwiftUI

struct CustomFont: ViewModifier {
    @StateObject var settingsViewModel: SettingsViewModel = .main

    func body(content: Content) -> some View {
        content
            .animation(.spring, value: settingsViewModel.fontSize)
            .animation(.spring, value: settingsViewModel.fontSize)
            .font(.custom(settingsViewModel.fontStyle.value, size: CGFloat(settingsViewModel.fontSize)))
    }
}

struct CustomNavTitleFont: ViewModifier {
    @StateObject var settingsViewModel: SettingsViewModel = .main

    let title: String

    func body(content: Content) -> some View {
        content
            .animation(.spring, value: settingsViewModel.fontSize)
            .animation(.spring, value: settingsViewModel.fontSize)
        #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
        #endif
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.custom(settingsViewModel.fontStyle.value, size: 20))
                }
            }
            .navigationTitle(title)
    }
}

struct FormattedStyleNumber: ViewModifier {
    @StateObject var settingsViewModel: SettingsViewModel = .main

    func body(content: Content) -> some View {
        content
            .font(.custom(CustomFontStyle.isepMisbah.value, size: CGFloat(settingsViewModel.fontSize), relativeTo: .body))
    }
}

#Preview {
    Text("Hello, world!")
        .modifier(FormattedStyleNumber())
}

extension Text {
    func withFormattedStyleNumber(_ settingsViewModel: SettingsViewModel) -> Text {
        font(.custom(CustomFontStyle.isepMisbah.value, size: CGFloat(settingsViewModel.fontSize), relativeTo: .body))
    }
}

extension View {
    func withCustomFont() -> some View {
        modifier(CustomFont())
    }

    func withCustomTitleFont(_ title: String) -> some View {
        modifier(CustomNavTitleFont(title: title))
    }

    func withFormattedStyleNumber() -> some View {
        modifier(FormattedStyleNumber())
    }
}
