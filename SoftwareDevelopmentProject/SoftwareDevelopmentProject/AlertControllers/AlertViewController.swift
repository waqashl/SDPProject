//
//  AlertViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/12/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit
import PopupDialog

class AlertViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var popUp: PopupDialog?
    var alertTitle: String?
    var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = alertTitle ?? ""
        self.messageLabel.text = message ?? ""
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func okBtnAction(_ sender: Any) {
        popUp!.dismiss()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
