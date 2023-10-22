//
//  RouterViewModel.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 21/10/23.
//

import Foundation
import SwiftUI

class RouterViewModel: Observable, ObservableObject {
    static let main = RouterViewModel()

    private init() {}

    @Published var path = NavigationPath()

    func add(_ value: any Hashable) {
        path.append(value)
    }
}
