//
//  LoginWorker.swift
//  Teste Solutis
//
//  Created by Virtual Machine on 15/09/21.
//

import Foundation

enum LoginWorkerError: String, Error {
    case invalidUsername = "Email inválido"
    case invalidPassword = "Senha inválida"
}

extension LoginWorkerError: LocalizedError {
    var errorDescription: String? { return NSLocalizedString(rawValue, comment: "") }
}

class LoginWorker {
    
    private let validation = ValidationUtils()
    private let loginService = LoginService()
    
    func doLogin(username: String, password: String, completionHandler: @escaping (Result<UserModel, Error>) -> Void) {
    
        if !isUsernameValid(username) {
            completionHandler(.failure(LoginWorkerError.invalidUsername))
            return
        }
        
        if !isPasswordValid(password) {
            completionHandler(.failure(LoginWorkerError.invalidPassword))
            return
        }
        
        loginService.performLoginRequest(username: username, password: password) { result in
            completionHandler(result)
            return
        }
    }
    
    private func isUsernameValid(_ username: String) -> Bool {
        return validation.isCpfOrCnpj(username) || validation.isEmail(username)
    }
    
    private func isPasswordValid(_ password: String) -> Bool {
        return validation.isPassword(password)
    }
}
