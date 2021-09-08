//
//  ViewController.swift
//  teste-solutis
//
//  Created by Virtual Machine on 30/08/21.
//

import UIKit
import SVProgressHUD
import KeychainSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var fieldUser: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    var loginService = LoginService()
    
    var user: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginService.delegate = self
        
        let keyChain = KeychainSwift()
        self.fieldUser.text = keyChain.get("kUsername")
        
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
    
    @IBAction func loginPressed(_ sender: UIButton) {
        sender.isEnabled = false
        
        let validation = ValidationUtils()
        
        guard let username = fieldUser.text else { return }
        guard let password = fieldPassword.text else { return }
        
        let isCpf = validation.isCpfOrCnpj(username)
        let isEmail = validation.isEmail(username)
        if !isCpf && !isEmail {
            setErrorField(fieldUser, error: true)
            showErrorAlert(message: "E-mail inválido")
            sender.isEnabled = true
            return
        }
        setErrorField(fieldUser, error: false)
        
        let isPassword = validation.isPassword(password)
        if !isPassword {
            setErrorField(fieldPassword, error: true)
            showErrorAlert(message: "Senha inválida")
            sender.isEnabled = true
            return
        }
        setErrorField(fieldPassword, error: false)
    
        // let username = "teste@teste.com.br"
        // let password = "abc123@"
        
        SVProgressHUD.show()
        loginService.doLogin(username: username, password: password)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeController" {
            let controller = segue.destination as! HomeViewController
            controller.user = user
        }
    }
}

// MARK: - Login Service Delegate Methods
extension LoginViewController: LoginServiceDelegate {
    func didPerformLogin(_ loginService: LoginService, username: String, user: UserModel) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            self.user = user
            
            let keyChain = KeychainSwift()
            keyChain.set(username, forKey: "kUsername")
                
            self.performSegue(withIdentifier: "homeController", sender: self)
        }
    }
    
    func didFailWithoutError(_ loginService: LoginService, message: String) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            self.btnLogin.isEnabled = true
            self.fieldPassword.text = ""
            self.showErrorAlert(message: message)
        }
    }
    
    func didFailWithError(_ loginService: LoginService, error: Error) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            self.btnLogin.isEnabled = true
            self.showErrorAlert(message: "Ocorreu um erro desconhecido")
            print(error)
        }
    }
}

