//
//  ProductView.swift
//  TiendaPratica
//
//  Created by Osasu sanchez on 19/10/25.
//

import SwiftUI

struct ProductView: View {
   
    var producto : Producto
    
    var body: some View {
        VStack(spacing:10){
            HStack(alignment: .top){
                AsyncImage(url: URL(string: producto.image)){ phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .padding(4)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .padding(.leading, 1)
                    case .success(let image):
                        image.resizable()
                            .frame(width: 120, height: 120)
                            .padding(4)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .padding(.leading, 1)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .padding(4)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .padding(.leading, 1)
                    @unknown default:
                        EmptyView()
                    }
                }
                VStack(alignment:.leading){
                    Text(producto.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .fontWidth(.compressed)
                        .multilineTextAlignment(.leading)
                        .padding(4)
                        .lineLimit(2)
                    Spacer()
                    
                    Text("Precio: \(producto.price ,format: .currency(code: "EUR"))")
                        .font(.footnote)
                        .fontWidth(.compressed)
                        .padding(2)
                    Text("Stock: \(producto.stock)")
                        .font(.footnote)
                       .fontWidth(.compressed)
                      Text("Tipo:\(producto.types.map(\.rawValue).joined(separator: ", "))")
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                }
                .frame(width: 200, alignment: .init(horizontal: .leading, vertical: .top))
                
            }
            
        }
        .frame(width: 350, height: 120)
    }
}

#Preview {
    ProductView(producto: Producto(
        image: "https://picsum.photos/200/300",
        name: "Producto de ejemplo",
        price: 19.99,
        stock: 10,
        types: [.casa, .acesroy]
    ))
}
