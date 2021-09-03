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
        
        return ""
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
