//
//  ContentView.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 07/10/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var quranViewModel: QuranViewModel

    var body: some View {
        view
    }

    @ViewBuilder var view: some View {
        switch quranViewModel.state {
            case .loading:
                ProgressView()
            case let .loaded(surahs):
                List {
                    ForEach(surahs) { surah in
                        if let surahName = surah.name?.short {
                            Text(surahName)
                        }
                    }
                }
            case let .failure(error):
                Text(error)
        }
    }
}

#Preview {
    ContentView()
}
