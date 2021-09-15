//
//  HomeModels.swift
//  teste-solutis
//
//  Created by Virtual Machine on 15/09/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Home {
  
    enum DisplayUser {
        struct Request {
            var user: UserModel
        }
        
        struct Response {
            var user: UserModel
        }
        
        struct ViewModel {
            var user: UserModel
        }
    }
    
    enum FetchStatements {
        struct Request {
        }
        
        struct Response {
            var statement: [StatementModel]
        }
        
        struct ViewModel {
            var statement: [StatementModel]
        }
    }
}
