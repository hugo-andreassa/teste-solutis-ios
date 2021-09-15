//
//  HomeViewController.swift
//  teste-solutis
//
//  Created by Virtual Machine on 02/09/21.
//

import UIKit
import SVProgressHUD

protocol HomeDisplayLogic {
    func displayUser(viewModel: LoginModels.DoLogin.ViewModel)
    func displayStatements(viewModel: LoginModels.DoLogin.ViewModel)
    func displayError(errorMessage: String)
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var nomeField: UILabel!
    @IBOutlet weak var cpfField: UILabel!
    @IBOutlet weak var saldoField: UILabel!
    
    var interactor: HomeBusinessLogic?
    var user: UserModel?
    var statementList: [StatementModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVIP()
        setGradient()
        setupUserData()
        requestStatementData()
    }
    
    func setGradient() {
        let gradient = CAGradientLayer()
        
        gradient.frame = self.gradientView!.bounds
        
        let color1 = UIColor(red: 177/256, green: 199/256, blue: 228/256, alpha: 1.0).cgColor
        let color2 = UIColor(red: 0/256, green: 116/256, blue: 178/256, alpha: 1.0).cgColor
        gradient.colors = [color1, color2]
        
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        self.gradientView.layer.insertSublayer(gradient, at: 0)
    }
    
    private func setupVIP() {
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.controller = self
    }
    
    func setupUserData() {
        interactor?.displayUser(request: Home.DisplayUser.Request(user: user!))
        
//        if let safeUser = user {
//            self.nomeField.text = safeUser.name
//            self.cpfField.text = safeUser.formattedCPF
//            self.saldoField.text = safeUser.formattedBalance
//        }
    }
    
    func requestStatementData() {
        if let token = user?.token {
            SVProgressHUD.show()
            
            // statementService.getExtract(token: token)
        }
    }
    
    @IBAction func exitPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Atenção", message: "Deseja mesmo sair?", preferredStyle: .alert)
        let sairAction = UIAlertAction(title: "Sair", style: .default, handler: {_ in
            self.performSegue(withIdentifier: "loginController", sender: self)
        })
        let cancelarAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: {_ in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(sairAction)
        alert.addAction(cancelarAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - HomeServiceDelegate
extension HomeViewController: HomeDisplayLogic {
    func displayUser(viewModel: LoginModels.DoLogin.ViewModel) {
        self.nomeField.text = viewModel.user?.name
        self.cpfField.text = viewModel.user?.formattedCPF
        self.saldoField.text = viewModel.user?.formattedBalance
    }
    
    func displayStatements(viewModel: LoginModels.DoLogin.ViewModel) {
        
    }
    
    func displayError(errorMessage: String) {
        
    }
    
//    func didUpdateExtract(_ statementService: StatementService, statementList: [StatementModel]) {
//        DispatchQueue.main.async {
//            self.statementList = statementList
//            self.tableView.reloadData()
//            SVProgressHUD.dismiss()
//        }
//    }
//
//    func didFailWithoutError(_ statementService: StatementService, message: String) {
//        DispatchQueue.main.async {
//            SVProgressHUD.dismiss()
//            print(message)
//        }
//    }
//
//    func didFailWithError(_ statementService: StatementService, error: Error) {
//        DispatchQueue.main.async {
//            SVProgressHUD.dismiss()
//            print(error)
//        }
//    }
}

// MARK: - UITableDelegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statementList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = statementList[(indexPath as NSIndexPath).row]
        
        if item.type == "Pagamento" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "pagamentoCell", for: indexPath) as! StatementTableViewCell
            cell.dateLabel.text = item.formattedDate
            cell.descriptionLabel.text = item.description
            cell.typeLabel.text = item.type
            cell.valueLabel.text = item.formattedValue
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recebimentoCell", for: indexPath) as! StatementTableViewCell
            cell.dateLabel.text = item.formattedDate
            cell.descriptionLabel.text = item.description
            cell.typeLabel.text = item.type
            cell.valueLabel.text = item.formattedValue
            
            return cell
        }
    }
}
