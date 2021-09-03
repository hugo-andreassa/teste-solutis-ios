//
//  ExtractModel.swift
//  teste-solutis
//
//  Created by Virtual Machine on 03/09/21.
//

import Foundation

struct ExtractModel {
    let description: String?
    let value: Double?
    let date: String?
    
    var formattedValue: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt-BR")
        formatter.numberStyle = .currency
        
        guard let safeValue = self.value else { return "Erro" }
        guard let formattedValue = formatter.string(from: safeValue as NSNumber) else { return "Erro" }
            
        return formattedValue
    }
    
    var formattedDate: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"

        if let date = dateFormatterGet.date(from: self.date!) {
            return dateFormatterPrint.string(from: date)
        } else {
           return "Erro"
        }
    }
    
    var type: String {
        guard let safeValue = self.value else { return "Erro" }
    
        if safeValue <= 0 {
            return "Pagamento"
        } else {
            return "Recebimento"
        }
    }
}
