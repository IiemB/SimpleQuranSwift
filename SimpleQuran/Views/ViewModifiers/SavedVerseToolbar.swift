//
//  SavedVerseToolbar.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 21/10/23.
//

import SwiftUI

struct SavedVerseToolbar: ViewModifier {
    @State var savedVerseDisplayed = false

    @EnvironmentObject var savedVerses: SavedVersesViewModel

    func body(content: Content) -> some View {
        content
            .toolbar {
                if !savedVerses.savedVerses.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("marks-locale", systemImage: "bookmark.fill") {
                            savedVerseDisplayed.toggle()
                        }
                    }
                }
            }
            .sheet(isPresented: $savedVerseDisplayed) {
                SavedVersesView()
            }
    }
}

extension View {
    func withSavedVerseToolbar() -> some View {
        modifier(SavedVerseToolbar())
    }
}
