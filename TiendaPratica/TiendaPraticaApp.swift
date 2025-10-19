//
//  TiendaPraticaApp.swift
//  TiendaPratica
//
//  Created by Osasu sanchez on 12/10/25.
//

import SwiftUI
import SwiftData

@main
struct TiendaPraticaApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            Producto.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])

            // Seed inicial: insertar productosEjemplo si no hay productos en la base
            let context = ModelContext(container)
            let descriptor = FetchDescriptor<Producto>(predicate: nil)
            let existing = try? context.fetch(descriptor)

            if (existing?.isEmpty ?? true) {
                // Inserta los productos definidos en Productos.swift
                for p in productosEjemplo {
                    context.insert(p)
                }
                try? context.save()
            }

            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
