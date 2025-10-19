//
//  ContentView.swift
//  TiendaPratica
//
//  Created by Osasu sanchez on 12/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Producto.name) public var productos: [Producto]
    @State private var showingAddSheet = false
   
    
    var body: some View {
       
        NavigationStack {
            List {
                if productos.isEmpty {
                    ContentUnavailableView(
                        "Sin productos",
                        systemImage: "shippingbox",
                        description: Text("Agrega productos usando el botón +")
                    )
                } else {
                    ForEach(productos) { producto in
                        ProductView(producto: producto)
                    }
                    .onDelete(perform: deleteProducto)
                    
                }
            }
            .navigationTitle("Productos")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddSheet.toggle()
                    } label: {
                        Label("Agregar producto", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddProductoView()
                    .presentationDetents([.large])
            }
        }
    }
    
    private func deleteProducto(at offsets: IndexSet) {
        for index in offsets {
            context.delete(productos[index])
        }
        try? context.save()
    }
}

// MARK: - Vista para agregar productos
struct AddProductoView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var price = ""
    @State private var stock = ""
    @State private var selectedTypes: Set<typesPorducto> = []
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Detalles del producto") {
                    TextField("Nombre", text: $name)
                    TextField("Precio", text: $price)
                        .keyboardType(.decimalPad)
                    TextField("Stock", text: $stock)
                        .keyboardType(.numberPad)
                }
                
                Section("Tipos") {
                    ForEach(typesPorducto.allCases) { tipo in
                        MultipleSelectionRow(
                            title: tipo.rawValue,
                            isSelected: selectedTypes.contains(tipo)
                        ) {
                            if selectedTypes.contains(tipo) {
                                selectedTypes.remove(tipo)
                            } else {
                                selectedTypes.insert(tipo)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Nuevo Producto")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar", action: saveProducto)
                        .disabled(name.isEmpty || price.isEmpty || stock.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar", role: .cancel) { dismiss() }
                }
            }
        }
    }
    
    private func saveProducto() {
        guard let priceValue = Double(price),
              let stockValue = Int(stock) else { return }
        
        let producto = Producto(
            image: "",
            name: name,
            price: priceValue,
            stock: stockValue,
            types: Array(selectedTypes)
        )
        
        context.insert(producto)
        try? context.save()
        dismiss()
    }
}

// MARK: - Vista auxiliar para selección múltiple
struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.blue)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
