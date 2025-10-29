//
//  User.swift
//  TiendaPratica
//
//  Created by Osasu sanchez on 30/10/25.
//

import Foundation
import SwiftData

@Model
final class User: Identifiable {
 
    var email: String
    var password: String
    var name: String
    var lastName: String
    var isAdmin: Bool
    
    
    init(email: String, password: String, name: String, lastName: String, isAdmin: Bool) {
        
        self.email = email
        self.password = password
        self.name = name
        self.lastName = lastName
        self.isAdmin = isAdmin
    }
    
    
}

