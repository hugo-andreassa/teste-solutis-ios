//
//  LoginPresenter.swift
//  Teste Solutis
//
//  Created by Virtual Machine on 15/09/21.
//

import Foundation

protocol LoginPresentationLogic {
    func presentUser(_ response: LoginModels.DoLogin.Response)
    func presentError(_ errorMessage: String)
}

class LoginPresenter: LoginPresentationLogic {
    var controller: LoginDisplayLogic?
    
    func presentUser(_ response: LoginModels.DoLogin.Response) {
        controller?.displayUser(viewModel:  LoginModels.DoLogin.ViewModel(user: response.user))
    }
    
    func presentError(_ errorMessage: String) {
        controller?.displayError(errorMessage: errorMessage)
    }
}
