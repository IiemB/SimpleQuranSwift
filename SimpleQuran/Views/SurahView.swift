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

    var body: some View {
        view
            .withCustomTitleFont(surah.surahName)
            .withSettingsMenuItem()
            .enableInjection()
    }

    @ViewBuilder var view: some View {
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

            ForEach(surah.surahVerses) { verse in
                HStack(alignment: .firstTextBaseline) {
                    Text(verse.verseNumber)
                        .withFormattedStyleNumber()
                    Spacer()
                    Text(verse.arabText)
                        .multilineTextAlignment(.trailing)
                        .withCustomFont()
                }
                .swipeActions(edge: .trailing) {
                    Button {} label: {
                        Label("Mark", systemImage: "flag")
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    SurahView(surah: .sample)
}
