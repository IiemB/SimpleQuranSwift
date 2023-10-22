//
//  SavedVersesView.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 21/10/23.
//

import SwiftUI

struct SavedVersesView: View {
    @EnvironmentObject var savedVerses: SavedVersesViewModel

    @StateObject var router: RouterViewModel = .main

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            List {
                ForEach(savedVerses.savedVerses) { savedVerse in
                    HStack {
                        Text(savedVerse.verse.verseNumber)
                            .withFormattedStyleNumber()
                        Spacer()
                        Text(savedVerse.surah.surahName)
                            .withCustomFont()
                    }
                    .onTapGesture {
                        router.add(savedVerse)
                        dismiss()
                    }
                }
                .onDelete { indexSet in
                    savedVerses.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, offset in
                    savedVerses.onReoreder(indexSet, offset)
                }
            }
            .listStyle(.plain)
            .onChange(of: savedVerses.savedVerses) { _, newValue in
                if newValue.isEmpty { dismiss() }
            }
            .navigationTitle("marks-locale")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SavedVersesView()
}
