//
//  User.swift
//  teste-solutis
//
//  Created by Virtual Machine on 30/08/21.
//

import Foundation

class User {
    var name: String?
    var cpf: String?
    var saldo: Double?
    var token: String?
        
    init(name: String, cpf: String, saldo: Double, token: String) {
        self.name = name
        self.cpf = cpf
        self.saldo = saldo
        self.token = token
    }    
}
