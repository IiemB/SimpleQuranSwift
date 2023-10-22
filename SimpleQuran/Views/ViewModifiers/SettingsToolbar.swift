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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("settings-locale", systemImage: "gear") {
                        Menu("language-locale") {
                            Picker("language-locale", selection: $settingsViewModel.lang) {
                                ForEach(Language.langs, id: \.id) { lang in
                                    Text(lang.label)
                                        .tag(lang)
                                }
                            }
                        }

                        Menu("fontSize-locale") {
                            Picker("fontSize-locale", selection: $settingsViewModel.fontSize) {
                                ForEach(fontSizes, id: \.self) { size in
                                    Text("\(size)")
                                        .tag(size)
                                }
                            }
                        }

                        Menu("fontStyle-locale") {
                            Picker("fontStyle-locale", selection: $settingsViewModel.fontStyle) {
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
}

extension View {
    func withSettingsMenuItem() -> some View {
        modifier(SettingsMenuItem())
    }
}
