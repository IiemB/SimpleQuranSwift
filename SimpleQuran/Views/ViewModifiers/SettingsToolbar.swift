//
//  SettingsToolbar.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 17/10/23.
//

import SwiftUI

struct SettingsMenuItem: ViewModifier {
    @StateObject var settingsViewModel: SettingsViewModel = .main

    private let fontSizes: Range<Int> = 20 ..< 51

    func body(content: Content) -> some View {
        content
            .toolbarTitleMenu {
                Menu("Settings") {
                    Menu("Font Size") {
                        Picker("Font Size", selection: $settingsViewModel.fontSize) {
                            ForEach(fontSizes, id: \.self) { size in
                                Text("\(size)")
                                    .tag(size)
                            }
                        }
                    }

                    Menu("Font Style") {
                        Picker("Font Style", selection: $settingsViewModel.fontStyle) {
                            ForEach(CustomFontStyle.fonts, id: \.id) { customFont in
                                Text(customFont.label)
                                    .tag(customFont)
                            }
                        }
                    }
                }
            }
    }
}

extension View {
    func withSettingsMenuItem() -> some View {
        modifier(SettingsMenuItem())
    }
}
