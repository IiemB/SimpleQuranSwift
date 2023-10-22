//
//  SavedVerse.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 19/10/23.
//

import Foundation

struct SavedVerse: Codable, Identifiable, Equatable, Hashable {
    static func == (lhs: SavedVerse, rhs: SavedVerse) -> Bool {
        lhs.id == rhs.id
    }

    var id: Int {
        verse.number?.inQuran ?? 0
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let surah: Surah
    let verse: Verse
}
