//
//  ValidationUtils.swift
//  teste-solutis
//
//  Created by Virtual Machine on 02/09/21.
//

import Foundation

class ValidationUtils {
    
    func isCpf() -> Bool {
        return true
    }

    func isEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func isPassword() -> Bool {
        return true
    }
}
