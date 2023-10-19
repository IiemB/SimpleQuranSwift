//
//  SimpleQuranApp.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 07/10/23.
//

@_exported import InjectHotReload
import SwiftUI

@main
struct SimpleQuranApp: App {
    @ObserveInjection var redraw

    @StateObject var quranViewModel = QuranViewModel()

    var body: some Scene {
        WindowGroup {
            QuranView()
                .environment(quranViewModel)
                .enableInjection()
        }
    }
}
