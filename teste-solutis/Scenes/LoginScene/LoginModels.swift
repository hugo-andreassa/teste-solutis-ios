//
//  LoginModels.swift
//  Teste Solutis
//
//  Created by Virtual Machine on 15/09/21.
//

import Foundation

class LoginModels {
    
    enum Login {
        struct Request {
            var username: String
            var password: String
        }
        
        struct Response {
            var user: UserModel?
        }
        
        struct ViewModel {
            var user: UserModel?
        }
    }
    
    enum SavedUsername {
        struct Request {
        }
        
        struct Response {
            var username: String
        }
        
        struct ViewModel {
            var username: String
        }
    }
}
