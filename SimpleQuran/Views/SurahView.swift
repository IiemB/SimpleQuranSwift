//
//  SurahView.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 15/10/23.
//

import SwiftUI

struct SurahView: View {
    @ObserveInjection var redraw

    let surah: Surah

    let verse: Verse?

    init(surah: Surah) {
        self.surah = surah
        self.verse = nil
    }

    init(surah: Surah, verse: Verse) {
        self.surah = surah
        self.verse = verse
    }

    var body: some View {
        view
            .withCustomTitleFont(surah.surahName)
            .withSettingsMenuItem()
            .enableInjection()
    }

    @ViewBuilder var view: some View {
        ScrollViewReader { controller in
            List {
                if let basmalah = surah.preBismillah?.text?.arab {
                    HStack(alignment: .center) {
                        Spacer()
                        Text(basmalah)
                            .multilineTextAlignment(.trailing)
                            .withCustomFont()
                        Spacer()
                    }
                }

                ForEach(surah.surahVerses, id: \.id) { verse in
                    VerseView(verse: verse, surah: surah)
                        .id(verse.id)
                }
            }
            .listStyle(.plain)
            .onAppear {
                if let verse = self.verse {
                    withAnimation(.spring) {
                        controller.scrollTo(verse.id)
                    }
                }
            }
        }
    }
}

private struct VerseView: View {
    let verse: Verse
    let surah: Surah

    @EnvironmentObject var savedVerses: SavedVersesViewModel

    var body: some View {
        verseText
            .contextMenu {
                markButton
            }
            .swipeActions(edge: .trailing) {
                markButton
            }
    }

    @ViewBuilder var verseText: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("")
            Spacer()
            Group {
                if savedVerses.isSaved(verseOf: verse) {
                    Text(Image(systemName: "bookmark.fill"))
                        .font(.footnote)
                        .foregroundStyle(Color.red)
                        +
                        Text(" ")
                        +
                        Text(verse.arabText)
                        +
                        Text(verse.verseNumber)
                        .withFormattedStyleNumber(.main)
                } else {
                    Text(verse.arabText)
                        +
                        Text(verse.verseNumber)
                        .withFormattedStyleNumber(.main)
                }
            }
            .multilineTextAlignment(.trailing)
            .withCustomFont()
        }
        .environment(\.locale, .init(identifier: "ar"))
        .animation(.spring, value: savedVerses.savedVerses)
    }

    @ViewBuilder var markButton: some View {
        if savedVerses.isSaved(verseOf: verse) {
            Button {
                savedVerses.remove(verse)
            } label: {
                Label("unmark-locale", systemImage: "bookmark.slash.fill")
            }

        } else {
            Button {
                savedVerses.add(SavedVerse(surah: surah, verse: verse))
            } label: {
                Label("mark-locale", systemImage: "bookmark.fill")
            }
        }
    }
}

#Preview {
    SurahView(surah: .sample)
}
