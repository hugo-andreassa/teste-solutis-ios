//
//  UserModel.swift
//  teste-solutis
//
//  Created by Virtual Machine on 02/09/21.
//

import Foundation

struct UserModel {
    let name: String?
    let cpf: String?
    let balance: Double?
    let token: String?
    
    var formattedCPF: String {
        guard let cpf = self.cpf else { return "Erro" }
        
        if cpf.count == 11 {
            var characters = Array(cpf)

            characters.insert(".", at: 3)
            characters.insert(".", at: 7)
            characters.insert("-", at: 11)
            
            let masked = String(characters)
            return masked
        } else {
            var characters = Array(cpf)

            characters.insert(".", at: 2)
            characters.insert(".", at: 6)
            characters.insert("/", at: 9)
            characters.insert("-", at: 13)
            
            let masked = String(characters)
            return masked
        }
    }
    
    var formattedBalance: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt-BR")
        formatter.numberStyle = .currency
        
        guard let safeValue = self.balance else { return "Erro" }
        guard let formattedValue = formatter.string(from: safeValue as NSNumber) else { return "Erro" }
            
        return formattedValue
    }
}
