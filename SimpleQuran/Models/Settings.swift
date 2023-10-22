//
//  Settings.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 18/10/23.
//

import Foundation

struct Settings: Codable {
    let fontSize: Int
    let fontStyle: CustomFontStyle
    let lang: Language

    func copyWith(fontSize: Int? = nil, fontStyle: CustomFontStyle? = nil, lang: Language? = nil) -> Settings {
        Settings(fontSize: fontSize ?? self.fontSize, fontStyle: fontStyle ?? self.fontStyle, lang: lang ?? self.lang)
    }

    static let initial: Settings = .init(fontSize: 20, fontStyle: .isepMisbah, lang: .en)
}

struct Language: Hashable, Identifiable, Codable {
    var id: String {
        self.value
    }

    let value: String
    let label: String

    static let id = Language(value: "id", label: "Bahasa Indonesia")

    static let en = Language(value: "en", label: "English")

    static let langs: [Language] = [.id, .en]
}

struct CustomFontStyle: Hashable, Identifiable, Codable {
    var id: String {
        self.value
    }

    let value: String
    let label: String

    static let isepMisbah = CustomFontStyle(value: "LPMQIsepMisbah", label: "Isep Misbah")

    static let alQalamMajeed = CustomFontStyle(value: "AlQalamQuranMajeedWeb", label: "Al Qalam Majeed")

    static let nooreHira = CustomFontStyle(value: "noorehira", label: "Noore Hira")

    static let fonts: [CustomFontStyle] = [.alQalamMajeed, .isepMisbah, .nooreHira]
}
