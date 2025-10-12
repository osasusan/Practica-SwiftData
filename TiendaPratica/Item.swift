//
//  Item.swift
//  TiendaPratica
//
//  Created by Osasu sanchez on 12/10/25.
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
