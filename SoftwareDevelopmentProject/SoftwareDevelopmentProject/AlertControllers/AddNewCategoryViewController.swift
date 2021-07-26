//
//  AddNewCategoryViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/26/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit
import PopupDialog

class AddNewCategoryViewController: BaseViewController {

    var popUp: PopupDialog?

    @IBOutlet weak var categoryTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addBtnAction(_ sender: Any) {
        guard let name = categoryTextField.text?.trimmingCharacters(in: .whitespaces) else {
            return
        }
        
        if name == "" {
            self.showErrorAlert(title: "Error", message: "Category Name Required.")
        }
        else {
            //add new category
            let param = ["category":name]
            let url = "category/add"
            
            RestApiManager.sharedInstance.makePostRequest(vc: self, url: url, params: param, successCompletionHandler: { (data) in
                
                self.popUp?.dismiss()
                
            }) { (err) in
                print(err)
            }
        }
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        popUp?.dismiss()
    }
    

}
