//
//  RoundedButton.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/4/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable var cornerRadiusValue: CGFloat = 0.0 {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            setUpView()
        }
    }
    
    @IBInspectable var borderColor: CGColor = UIColor.white.cgColor {
        didSet {
            setUpView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    func setUpView() {
        self.layer.cornerRadius = self.cornerRadiusValue
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor
        
        self.clipsToBounds = true
    }
}
