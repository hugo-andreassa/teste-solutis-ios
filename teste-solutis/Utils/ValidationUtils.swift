//
//  ValidationUtils.swift
//  teste-solutis
//
//  Created by Virtual Machine on 02/09/21.
//

import Foundation
import CPF_CNPJ_Validator

class ValidationUtils {
    
    func isCpfOrCnpj(_ cpfCnpj: String) -> Bool {
        let cpf = BooleanValidator().validate(cpfCnpj, kind: .CPF)
        let cnpj = BooleanValidator().validate(cpfCnpj, kind: .CNPJ)
        
        return cpf || cnpj
    }

    func isEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func isPassword(_ password: String) -> Bool {
        return !password.isEmpty
    }
}
