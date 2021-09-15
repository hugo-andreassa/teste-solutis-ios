//
//  LoginService.swift
//  Teste Solutis
//
//  Created by Virtual Machine on 15/09/21.
//

import Foundation

enum LoginServiceError: String, Error {
    
    case invalidRequest = "Ocorreu um erro desconhecido ao fazer a requisição"
    case invalidParse = "Ocorreu um erro desconhecido ao processar os dados"
    case invalidParameters = "Usuário ou senha inválido"
}

extension LoginServiceError: LocalizedError {
    var errorDescription: String? { return NSLocalizedString(rawValue, comment: "") }
}

class LoginService {
    
    private let apiUrl = NSLocalizedString("ApiURL", comment: "")
    
    func performLoginRequest(username: String, password: String, completionHandler: @escaping (Result<UserModel, Error>) -> Void) {
        let urlString = apiUrl + "login"
        let loginData = LoginData(username: username, password: password)
        
        if let url = URL(string: urlString) {
            do {
                let session = URLSession(configuration: .default)
                var request = URLRequest(url: url)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "POST"
                request.httpBody = try JSONEncoder().encode(loginData)
                
                let task = session.dataTask(with: request) { data, response, error in
                    if error != nil {
                        completionHandler(.failure(LoginServiceError.invalidRequest))
                        return
                    }
                    
                    if (response as! HTTPURLResponse).statusCode > 299 {
                        completionHandler(.failure(LoginServiceError.invalidParameters))
                        return
                    }
                    
                    if let safeData = data {
                        if let user = self.parseJson(safeData) {
                            completionHandler(.success(user))
                        } else {
                            completionHandler(.failure(LoginServiceError.invalidParse))
                        }
                    }
                }
                
                task.resume()
            } catch {
                completionHandler(.failure(LoginServiceError.invalidRequest))
            }
        }
    }
    
    private func parseJson(_ data: Data) -> UserModel? {
        do {
            let userData = try JSONDecoder().decode(UserData.self, from: data)
            let userModel = UserModel(
                name: userData.nome,
                cpf: userData.cpf,
                balance: userData.saldo,
                token: userData.token)
            return userModel
        } catch {
            return nil
        }
    }
}
