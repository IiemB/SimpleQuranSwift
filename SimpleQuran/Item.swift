//
//  Item.swift
//  SimpleQuran
//
//  Created by UKUR KREASI on 07/10/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
