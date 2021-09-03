//
//  LoginManager.swift
//  teste-solutis
//
//  Created by Virtual Machine on 02/09/21.
//

import Foundation

protocol LoginServiceDelegate {
    func didPerformLogin(_ loginService: LoginService, user: UserModel)
    func didFailWithError(_ loginService: LoginService, error: Error)
}

class LoginService {
    
    var delegate: LoginServiceDelegate?
    
    let apiUrl = NSLocalizedString("ApiURL", comment: "")
    
    func doLogin(username: String, password: String) {
        let url = apiUrl + "login"
        let login = LoginData(username: username, password: password)
        performRequest(with: url, loginData: login)
    }
    
    func performRequest(with urlString: String, loginData: LoginData) {
        if let url = URL(string: urlString) {
            do {
                let session = URLSession(configuration: .default)
                var request = URLRequest(url: url)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "POST"
                request.httpBody = try JSONEncoder().encode(loginData)
                
                let task = session.dataTask(with: request) { data, urlResponse, error in
                    if error != nil {
                        self.delegate?.didFailWithError(self, error: error!)
                        return
                    }
                    
                    if let safeData = data {
                        if let user = self.parseJson(safeData) {
                            self.delegate?.didPerformLogin(self, user: user)
                        }
                    }
                }
                
                task.resume()
            } catch {
                delegate?.didFailWithError(self, error: error)
            }
        }
    }
    
    func parseJson(_ data: Data) -> UserModel? {
        do {
            let userData = try JSONDecoder().decode(UserData.self, from: data)
            let userModel = UserModel(
                name: userData.nome,
                cpf: userData.cpf,
                balance: userData.saldo,
                token: userData.token)
            return userModel
        } catch {
            delegate?.didFailWithError(self, error: error)
            return nil
        }
    }
}
