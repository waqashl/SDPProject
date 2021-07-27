//
//  RegisterViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/4/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {
    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userAddress: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var userDOB: UITextField!

    let datePicker = UIDatePicker()
    var dateFormatter = DateFormatter()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        datePicker.datePickerMode = .date
        userDOB.inputView = datePicker
        setUpDatePicker()
        // Do any additional setup after loading the view.
        
        
        //Auto fill data
        userName.text = "Sumair"
        userEmail.text = "sumair@fulda.com"
        userAddress.text = "Campus Living Fulda"
        userPassword.text = "123456"
        confirmPassword.text = "123456"
        
    }
    
    
    
    func setUpDatePicker() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        

        toolBar.setItems([spaceButton,spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        userDOB.inputAccessoryView = toolBar
    }
    
    @objc func donePicker(_ sender:UIDatePicker) {
        userDOB.text = dateFormatter.string(from: datePicker.date)
        self.userDOB.resignFirstResponder()
    }
    
    @IBAction func registerBtnAction(_ sender: Any) {
    
        guard let name = userName?.text?.trimmingCharacters(in: .whitespaces) else { return }
        guard let address = userAddress?.text?.trimmingCharacters(in: .whitespaces) else { return }
        guard let email = userEmail?.text?.trimmingCharacters(in: .whitespaces) else { return }
        guard let password = userPassword?.text?.trimmingCharacters(in: .whitespaces) else { return }
        guard let confirmPassword = confirmPassword?.text?.trimmingCharacters(in: .whitespaces) else { return }
        guard let dob = userDOB?.text?.trimmingCharacters(in: .whitespaces) else { return }

        if (name == "" || email == "" || password == "" || address == "" || confirmPassword == "" || dob == "") {
            self.showErrorAlert(title: "Error", message: "All fields are required", delegate: nil)
        }
        else if (password == confirmPassword) {
        
            let date = dateFormatter.date(from: dob)
    
            let params = ["name": name, "email": email, "password" : password, "address": address, "dob":dob, "postalCode":"36037"]

            RestApiManager.sharedInstance.makePostRequest(vc: self, url: "user/register", params: params, successCompletionHandler: { (data) in
                
                guard let data = data as? [String: Any] else { return }
                
                if (data["status"] as! String == "Failed") {
                    let title = data["status"] as! String
                    let message = data["message"] as? String ?? ""
                    self.showErrorAlert(title: title, message: message, delegate: nil)
                }
                else {
                    self.showErrorAlert(title: "Success", message: "User successfully registered", delegate: self)
                }
                
                
            }) { (err) in
                print(err)
            }
        }
        else {
            self.showErrorAlert(title: "Error", message: "Password and Confrim Password must be same.", delegate: nil)
        }
        
    }
    
    
    @IBAction func signInBtn(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }

}

extension RegisterViewController: ErrorAlertDelegates {
    func okPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}
