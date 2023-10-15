//
//  SimpleQuranApp.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 07/10/23.
//

import SwiftUI

@main
struct SimpleQuranApp: App {
    let quranViewModel = QuranViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(quranViewModel)
        }
    }
}
