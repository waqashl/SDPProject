//
//  ConfirmationAlertViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/12/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit
import PopupDialog


class ConfirmationAlertViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var popUp: PopupDialog?
    var alertTitle: String?
    var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func okBtnAction(_ sender: Any) {
        popUp!.dismiss()
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        popUp!.dismiss()
    }

    
}
