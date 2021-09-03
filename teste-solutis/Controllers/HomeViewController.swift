//
//  HomeViewController.swift
//  teste-solutis
//
//  Created by Virtual Machine on 02/09/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setGradient()
        // setupLayoutCell()
    }
    
    /*func setupLayoutCell() {
        innerViewCell.layer.cornerRadius = 5
        innerViewCell.layer.masksToBounds = false
        innerViewCell.layer.shadowColor = UIColor.gray.cgColor
        innerViewCell.layer.shadowOffset = CGSize(width: 0, height: 3);
        innerViewCell.layer.shadowOpacity = 0.5
        innerViewCell.layer.borderWidth = 1.0
        innerViewCell.layer.borderColor = UIColor(red:0.00, green:0.87, blue:0.39, alpha:1.0).cgColor
    }*/
    
    func setGradient() {
        let gradient = CAGradientLayer()
        
        gradient.frame = topView.bounds
        
        let color1 = UIColor(red: 177/256, green: 199/256, blue: 228/256, alpha: 1.0).cgColor
        let color2 = UIColor(red: 0/256, green: 116/256, blue: 178/256, alpha: 1.0).cgColor
        gradient.colors = [color1, color2]
        
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        topView.layer.insertSublayer(gradient, at: 0)
    }
}

// MARK: - UITableDelegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
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
