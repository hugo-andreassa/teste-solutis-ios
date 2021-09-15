//
//  ViewController.swift
//  teste-solutis
//
//  Created by Virtual Machine on 30/08/21.
//

import UIKit
import SVProgressHUD
import KeychainSwift

protocol LoginDisplayLogic {
    func displayUser(viewModel: LoginModels.DoLogin.ViewModel)
    func displayError(errorMessage: String)
}

class LoginViewController: UIViewController {

    @IBOutlet weak var fieldUser: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    var user: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupVIP()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        guard let username = fieldUser.text, let password = fieldPassword.text else { return }
        
        SVProgressHUD.show()
        let request = LoginModels.DoLogin.Request(username: username, password: password)
        interactor?.doLogin(request: request)
    }
    
    private func setupUI() {
        btnLogin.layer.cornerRadius = 22
    }
    
    private func setupVIP() {
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.controller = self
        
        self.router = router
        router.viewController = self
        router.dataStore = interactor
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: {_ in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "homeController" {
//            let controller = segue.destination as! HomeViewController
//            controller.user = user
//        }
//    }
}

// MARK: - Login Display Logic
extension LoginViewController: LoginDisplayLogic {
    func displayUser(viewModel: LoginModels.DoLogin.ViewModel) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            self.router?.routeToHome(segue: nil)
        }
    }
    
    func displayError(errorMessage: String) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            self.showErrorAlert(message: errorMessage)
        }
    }
}
