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

    var body: some View {
        NavigationStack {
            view
                .navigationDestination(for: Surah.self) { surah in
                    SurahView(surah: surah)
                }
                .withCustomTitleFont("القرآن")
                .withSettingsMenuItem()
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
