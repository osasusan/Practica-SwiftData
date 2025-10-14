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

@Model
final class Porducto {
    var image: String
    var name: String
    var pirce: Double
    var stock: Int

    // Persist only the raw values
    var typeRawValues: [String]

    // Non-persisted computed property that maps to/from the raw values
    @Transient
    var types: [typesPorducto] {
        get { typeRawValues.compactMap { typesPorducto(rawValue: $0) } }
        set { typeRawValues = newValue.map { $0.rawValue } }
    }
    
    init(image: String, name: String, pirce: Double, stock: Int, types: [typesPorducto]) {
        self.image = image
        self.name = name
        self.pirce = pirce
        self.stock = stock
        self.typeRawValues = types.map { $0.rawValue }
    }
}

enum typesPorducto: String, CaseIterable, Identifiable {
    case ropa = "Ropa"
    case game = "Gmae"
    case acesroy = "Acesorios"
    case casa = "Casa"
    
    var id: String { self.rawValue }
}
