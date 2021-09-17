//
//  HomeViewController.swift
//  teste-solutis
//
//  Created by Virtual Machine on 02/09/21.
//

import UIKit
import SVProgressHUD

protocol HomeDisplayLogic {
    func displayUser(viewModel: HomeModels.DisplayUser.ViewModel)
    func displayStatements(viewModel: HomeModels.FetchStatements.ViewModel)
    func displayError(errorMessage: String)
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var nomeField: UILabel!
    @IBOutlet weak var cpfField: UILabel!
    @IBOutlet weak var saldoField: UILabel!
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    var statementList: [StatementModel] = []
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupVIP()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        setupGradient()
        setupUserData()
        requestStatementData()
    }
    
    func setupGradient() {
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
        let router = HomeRouter()
        
        self.interactor = interactor
        interactor.presenter = presenter
        presenter.controller = self
        
        self.router = router
        router.viewController = self
        router.dataStore = interactor
    }
    
    func setupUserData() {
        interactor?.displayUser(request: HomeModels.DisplayUser.Request())
    }
    
    func requestStatementData() {
        interactor?.fetchStatements(request: HomeModels.FetchStatements.Request())
    }
    
    @IBAction func exitPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Atenção", message: "Deseja mesmo sair?", preferredStyle: .alert)
        let sairAction = UIAlertAction(title: "Sair", style: .default, handler: {_ in
            self.router?.routeToLogin(segue: nil)
            // self.performSegue(withIdentifier: "loginController", sender: self)
        })
        let cancelarAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: {_ in
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(sairAction)
        alert.addAction(cancelarAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Home Display Logic
extension HomeViewController: HomeDisplayLogic {
    func displayUser(viewModel: HomeModels.DisplayUser.ViewModel) {
        DispatchQueue.main.async {
            self.nomeField.text = viewModel.user.name
            self.cpfField.text = viewModel.user.formattedCPF
            self.saldoField.text = viewModel.user.formattedBalance
        }
    }
    
    func displayStatements(viewModel: HomeModels.FetchStatements.ViewModel) {
        DispatchQueue.main.async {
            self.statementList = viewModel.statements
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    func displayError(errorMessage: String) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            print(errorMessage)
        }
    }
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
