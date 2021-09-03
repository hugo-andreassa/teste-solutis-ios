//
//  CardView.swift
//  teste-solutis
//
//  Created by Virtual Machine on 03/09/21.
//

import Foundation
import UIKit

@IBDesignable class CardView: UIView {
    
    var cornerRadius: CGFloat = 10
    var ofsetWidth: CGFloat = 5
    var ofsetHeight: CGFloat = 5
    
    var ofsetShadowOpacity: Float = 5
    var color = UIColor.systemGray4
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: ofsetWidth, height: ofsetHeight)
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.shadowOpacity = ofsetShadowOpacity
    }
}
