//
//  SimpleQuranApp.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 07/10/23.
//

@_exported import Inject
import SwiftUI

@main
struct SimpleQuranApp: App {
    @ObserveInjection var redraw

    @StateObject var quranViewModel = QuranViewModel()
    @StateObject var savedVerses = SavedVersesViewModel()

    @StateObject var settingsViewModel: SettingsViewModel = .main

    var body: some Scene {
        WindowGroup {
            QuranView()
                .environmentObject(quranViewModel)
                .environmentObject(savedVerses)
                .environment(\.locale, .init(identifier: settingsViewModel.lang.value))
                .enableInjection()
        }
    }
}
