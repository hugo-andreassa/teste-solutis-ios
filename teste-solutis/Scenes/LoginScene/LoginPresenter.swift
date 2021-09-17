//
//  LoginPresenter.swift
//  Teste Solutis
//
//  Created by Virtual Machine on 15/09/21.
//

import Foundation

protocol LoginPresentationLogic {
    func presentUser(_ response: LoginModels.Login.Response)
    func presentUsername(_ response: LoginModels.SavedUsername.Response)
    func presentError(_ errorMessage: String)
}

class LoginPresenter: LoginPresentationLogic {
    var controller: LoginDisplayLogic?
    
    func presentUsername(_ response: LoginModels.SavedUsername.Response) {
        controller?
            .displayUsername(
                viewModel: LoginModels.SavedUsername.ViewModel(username: response.username)
            )
    }

    func presentUser(_ response: LoginModels.Login.Response) {
        controller?.displayUser(viewModel:  LoginModels.Login.ViewModel(user: response.user))
    }
    
    func presentError(_ errorMessage: String) {
        controller?.displayError(errorMessage: errorMessage)
    }
}
