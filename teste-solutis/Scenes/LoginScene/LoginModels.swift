//
//  LoginModels.swift
//  Teste Solutis
//
//  Created by Virtual Machine on 15/09/21.
//

import Foundation

class LoginModels {
    
    enum DoLogin {
        struct Request {
            var username: String
            var password: String
        }
        
        struct Response {
            var user: UserModel?
        }
        
        struct ViewModel {
            var user: UserModel?
            
            struct LoginError {
                var error: Error?
                var message: String
            }
        }
        
    }
}
