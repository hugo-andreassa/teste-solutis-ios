//
//  HomeViewController.swift
//  teste-solutis
//
//  Created by Virtual Machine on 02/09/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pagamentoCell", for: indexPath) as! ExtratoTableViewCell
        
        cell.dateLabel.text = "01/12/2032"
        cell.descriptionLabel.text = "Pagamento conta de luz"
        cell.typeLabel.text = "Pagamento"
        cell.valueLabel.text = "- R$ 153,00"
        
        return cell
    }
    
}
