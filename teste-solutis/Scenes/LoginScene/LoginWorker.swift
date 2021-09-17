//
//  LoginWorker.swift
//  Teste Solutis
//
//  Created by Virtual Machine on 15/09/21.
//

import Foundation
import KeychainSwift

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

            switch result {
                case .success(_):
                    self.saveUsername(username)
                    break
                case .failure(_):
                    break
            }
            
            completionHandler(result)
            return
        }
    }
    
    func retrieveSavedUsername() -> String {
        let keychain = KeychainSwift()
        let username = keychain.get("kUsername")
        
        return username ?? ""
    }
    
    private func saveUsername(_ username: String) {
        let keychain = KeychainSwift()
        keychain.set(username, forKey: "kUsername")
    }
    
    private func isUsernameValid(_ username: String) -> Bool {
        return validation.isCpfOrCnpj(username) || validation.isEmail(username)
    }
    
    private func isPasswordValid(_ password: String) -> Bool {
        return validation.isPassword(password)
    }
}
