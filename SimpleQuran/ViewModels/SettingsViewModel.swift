//
//  SettingsViewModel.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 17/10/23.
//

import Foundation

class SettingsViewModel: Observable, ObservableObject {
    static let main = SettingsViewModel()

    @Published var fontSize: Int {
        didSet {
            savedSettings = savedSettings.copyWith(fontSize: fontSize)
        }
    }

    @Published var fontStyle: CustomFontStyle {
        didSet {
            savedSettings = savedSettings.copyWith(fontStyle: fontStyle)
        }
    }

    private var savedSettings: Settings {
        didSet {
            try? UserDefaultValues.setObject(savedSettings, forKey: .settings)
        }
    }

    private init() {
        let savedSettings = try? UserDefaultValues.getObject(forKey: .settings, castTo: Settings.self)

        self.savedSettings = savedSettings ?? .initial

        self.fontSize = self.savedSettings.fontSize
        self.fontStyle = self.savedSettings.fontStyle
    }
}
