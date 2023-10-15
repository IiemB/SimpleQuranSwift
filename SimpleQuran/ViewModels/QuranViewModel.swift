//
//  QuranViewModel.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 15/10/23.
//

import Foundation

enum QuranViewModelState {
    case loading
    case loaded([Surah])
    case failure(String)
}

class QuranViewModel: ObservableObject, Observable {
    @Published var state: QuranViewModelState = .loading

    init() {
        self.fetchQuran()
    }

    private func fetchQuran() {
        guard let url = Bundle.main.url(forResource: "quran", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let quranData = try? JSONDecoder().decode(Quran.self, from: data),
              let surahs = quranData.data
        else {
            self.state = .failure("Failed to read data")

            return
        }

        self.state = .loaded(surahs)
    }
}
