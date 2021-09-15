//
//  HomeInteractor.swift
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

protocol HomeBusinessLogic {
    func displayUser(request: HomeModels.DisplayUser.Request)
    func fetchStatements(request: HomeModels.FetchStatements.Request)
}

protocol HomeDataStore {
    var user: UserModel? { get set }
    var statements: [StatementModel]? { get }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    
    var user: UserModel?
    var statements: [StatementModel]?
    
    func displayUser(request: HomeModels.DisplayUser.Request) {
        presenter?.presentUser(user: user!)
    }
    
    func fetchStatements(request: HomeModels.FetchStatements.Request) {
        worker = HomeWorker()
        worker?.fetchStatements()
        
        // Present
    }
}
