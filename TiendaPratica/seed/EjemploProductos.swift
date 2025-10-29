//
//  Productos.swift
//  TiendaPratica
//
//  Created by Osasu sanchez on 15/10/25.
//

import Foundation

// Arreglo de productos de ejemplo (en memoria)
// Útil para previews o pruebas; no se usa por SwiftData automáticamente.
 var productosEjemplo: [Producto] = [
    Producto(
        image: "https://picsum.photos/200/300",
        name: "Cafetera",
        price: 20.00,
        stock: 3,
        types: [.casa]
    ),
    Producto(
        image: "https://picsum.photos/200/300",
        name: "Pijama",
        price: 59.00,
        stock: 20,
        types: [.ropa]
    ),
    Producto(
        image: "https://picsum.photos/200/300" ,
        name: "ninja",
        price: 299.00,
        stock: 39,
        types: [.game,.acesroy]
    ),
    Producto(
        image: "https://picsum.photos/200/300",
        name: "chaqueta",
        price: 29.00,
        stock: 39,
        types: [.ropa])
]
