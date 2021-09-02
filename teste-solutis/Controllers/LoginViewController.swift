//
//  ViewController.swift
//  teste-solutis
//
//  Created by Virtual Machine on 30/08/21.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController, LoginServiceDelegate {

    @IBOutlet weak var fieldUser: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    var loginService = LoginService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginService.delegate = self
        
        setupUI()
    }
    
    func setupUI() {
        btnLogin.layer.cornerRadius = 22
    }
    
    func setErrorField(_ textField: UITextField, error: Bool) {
        if error {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.red.cgColor
        } else {
            textField.layer.borderWidth = 0
            textField.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: {_ in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        /*let validation = ValidationUtils()
        
        guard let username = fieldUser.text else {
            setErrorField(fieldUser, error: true)
            return
        }
        guard let password = fieldUser.text else {
            setErrorField(fieldPassword, error: true)
            return
        }
        
        if !validation.isCpf() || !validation.isEmail() {
            setErrorField(fieldUser, error: true)
            showErrorAlert(message: "E-mail inválido")
            return
        }
        setErrorField(fieldUser, error: false)
        
        if !validation.isPassword() {
            setErrorField(fieldPassword, error: true)
            showErrorAlert(message: "Senha inválida")
            return
        }
        setErrorField(fieldPassword, error: false)*/
    
        let username = "teste@teste.com.br"
        let password = "abc123@"
        
        SVProgressHUD.show()
        loginService.doLogin(username: username, password: password)
    }
    
    // MARK: Login Service Delegate Methods
    func didPerformLogin(_ loginService: LoginService, user: UserModel) {
        SVProgressHUD.dismiss()
        print(user)
    }
    
    func didFailWithError(_ loginService: LoginService, error: Error) {
        SVProgressHUD.dismiss()
        print(error)
    }
}
