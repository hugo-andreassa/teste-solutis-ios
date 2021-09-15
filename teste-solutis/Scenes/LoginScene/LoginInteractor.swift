//
//  LoginInteractor.swift
//  Teste Solutis
//
//  Created by Virtual Machine on 15/09/21.
//

import Foundation

protocol LoginBusinessLogic {
    func doLogin(request: LoginModels.DoLogin.Request)
}

protocol LoginDataStore {
  var user: UserModel? { get }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    
    var presenter: LoginPresentationLogic?
    
    var loginWorker = LoginWorker()
    var user: UserModel?
    
    func doLogin(request: LoginModels.DoLogin.Request) {

        loginWorker.doLogin(username: request.username, password: request.password) { result in
            switch result {
                case .success(let user):
                    self.user = user
                    self.presenter?.presentUser(.init(user: user))
                    return
                
                case .failure(let e):
                    self.presenter?.presentError(e.localizedDescription)
                    return
            }
        }
    }
}
