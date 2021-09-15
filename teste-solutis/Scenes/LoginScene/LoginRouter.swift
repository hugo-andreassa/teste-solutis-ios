//
//  LoginRouter.swift
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

@objc protocol LoginRoutingLogic
{
    func routeToHome(segue: UIStoryboardSegue?)
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    
    var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    // MARK: Routing
    func routeToHome(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! HomeViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToHomeController(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToHomeController(source: dataStore!, destination: &destinationDS)
            navigateToHomeController(source: viewController!, destination: destinationVC)
        }
    }
    
    // MARK: Navigation
    func navigateToHomeController(source: LoginViewController, destination: HomeViewController) {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    func passDataToHomeController(source: LoginDataStore, destination: inout HomeDataStore) {
        destination.user = source.user
    }
}
