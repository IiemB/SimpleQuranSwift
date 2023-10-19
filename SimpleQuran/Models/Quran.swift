//
//  Quran.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 15/10/23.
//

import Foundation

// MARK: - Quran

struct Quran: Codable {
    let license: String?
    let source: String?
    let audioEdition: String?
    let data: [Surah]?
}

// MARK: - Surah

struct Surah: Codable, Identifiable, Hashable {
    static func == (lhs: Surah, rhs: Surah) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var id: String {
        UUID().uuidString
    }

    let number, sequence, numberOfVerses: Int?
    let name: Name?
    let revelation: Revelation?
    let tafsir: DatumTafsir?
    let preBismillah: PreBismillah?
    let verses: [Verse]?

    var surahName: String {
        name?.short ?? "Surah Name"
    }

    var surahNumber: String {
        "\(number ?? 0)".convertedDigitsToLocale(Locale(identifier: "AR"))
    }

    var surahVerses: [Verse] {
        verses ?? [Verse]()
    }

    static let sample = Surah(number: nil, sequence: nil, numberOfVerses: nil, name: nil, revelation: nil, tafsir: nil, preBismillah: nil, verses: nil)
}

// MARK: - Name

struct Name: Codable {
    let short, long: String?
    let transliteration, translation: Translation?
}

// MARK: - Translation

struct Translation: Codable {
    let en, id: String?
}

// MARK: - PreBismillah

struct PreBismillah: Codable {
    let text: QuranText?
    let translation: Translation?
    let audio: Audio?
}

// MARK: - Audio

struct Audio: Codable {
    let primary: String?
    let secondary: [String]?
}

// MARK: - QuranText

struct QuranText: Codable {
    let arab: String?
    let transliteration: Transliteration?
}

// MARK: - Transliteration

struct Transliteration: Codable {
    let en: String?
}

// MARK: - Revelation

struct Revelation: Codable {
    let arab, en, id: String?
}

// MARK: - DatumTafsir

struct DatumTafsir: Codable {
    let id: String?
}

// MARK: - Verse

struct Verse: Codable, Identifiable {
    var id: String {
        UUID().uuidString
    }

    let number: Number?
    let meta: Meta?
    let text: QuranText?
    let translation: Translation?
    let audio: Audio?
    let tafsir: VerseTafsir?

    var arabText: String {
        (text?.arab ?? "")
    }

    var verseNumber: String {
        "\(number?.inSurah ?? 0)".convertedDigitsToLocale(Locale(identifier: "AR"))
    }
}

// MARK: - Meta

struct Meta: Codable {
    let juz, page, manzil, ruku: Int?
    let hizbQuarter: Int?
    let sajda: Sajda?
}

// MARK: - Sajda

struct Sajda: Codable {
    let recommended, obligatory: Bool?
}

// MARK: - Number

struct Number: Codable {
    let inQuran, inSurah: Int?
}

// MARK: - VerseTafsir

struct VerseTafsir: Codable {
    let id: Id?
}

// MARK: - Id

struct Id: Codable {
    let short, long: String?
}
