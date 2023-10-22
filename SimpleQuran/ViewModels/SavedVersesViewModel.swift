//
//  SavedAyahsViewModel.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 19/10/23.
//

import Foundation

class SavedVersesViewModel: Observable, ObservableObject {
    @Published var savedVerses: [SavedVerse] {
        didSet {
            try? UserDefaultValues.setObject(savedVerses, forKey: .savedVerses)
        }
    }

    init() {
        let savedVerses = try? UserDefaultValues.getObject(forKey: .savedVerses, castTo: [SavedVerse].self)
        self.savedVerses = savedVerses ?? [SavedVerse]()
    }

    func isSaved(verseOf verse: Verse) -> Bool {
        savedVerses.contains { savedVerse in
            savedVerse.verse == verse
        }
    }

    func add(_ verse: SavedVerse) {
        savedVerses.append(verse)
    }

    func remove(_ verse: Verse) {
        savedVerses.removeAll { savedVerse in
            savedVerse.verse == verse
        }
    }

    func remove(atOffsets offsets: IndexSet) {
        savedVerses.remove(atOffsets: offsets)
    }

    func onReoreder(_ indexSet: IndexSet, _ offset: Int) {
        savedVerses.move(fromOffsets: indexSet, toOffset: offset)
    }
}
