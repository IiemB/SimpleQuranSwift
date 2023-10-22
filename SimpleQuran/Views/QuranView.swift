//
//  ContentView.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 07/10/23.
//

import SwiftUI

struct QuranView: View {
    @ObserveInjection var redraw

    @EnvironmentObject var quranViewModel: QuranViewModel
    @StateObject var router: RouterViewModel = .main

    var body: some View {
        NavigationStack(path: $router.path) {
            view
                .navigationDestination(for: Surah.self) { surah in
                    SurahView(surah: surah)
                }
                .navigationDestination(for: SavedVerse.self) { savedVerse in
                    SurahView(surah: savedVerse.surah, verse: savedVerse.verse)
                }
                .withCustomTitleFont("القرآن")
                .withSettingsMenuItem()
                .withSavedVerseToolbar()
        }
        .enableInjection()
    }

    @ViewBuilder var view: some View {
        switch quranViewModel.state {
            case .loading:
                ProgressView()
            case let .loaded(surahs):
                List {
                    ForEach(surahs) { surah in
                        NavigationLink(value: surah) {
                            HStack {
                                Text(surah.surahNumber)
                                    .withFormattedStyleNumber()
                                Spacer()
                                Text(surah.surahName)
                                    .withCustomFont()
                            }
                        }
                    }
                }
                .listStyle(.plain)
            case let .failure(error):
                Text(error)
        }
    }
}

#Preview {
    QuranView()
}
