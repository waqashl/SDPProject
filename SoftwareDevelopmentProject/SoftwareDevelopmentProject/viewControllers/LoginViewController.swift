//
//  LoginViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/4/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit
import PopupDialog

class LoginViewController: BaseViewController {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmail.text = "abc@abc.com"
        userPassword?.text = "ppp"

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //userLoginSegue
    //adminLoginSegue
    @IBAction func loginBtnAction(_ sender: Any) {
        
        guard let email = userEmail?.text?.trimmingCharacters(in: .whitespaces) else {
            return
        }
        
        guard let password = userPassword?.text?.trimmingCharacters(in: .whitespaces) else {
            return
        }
        
        let params = ["email": email, "password" : password]
        
        RestApiManager.sharedInstance.makePostRequest(vc: self, url: "user/login", params: params, successCompletionHandler: { (data) in
            
            guard let data = data as? [String: Any] else { return }
            
            if (data["status"] as! String == "Failed") {
                let title = data["status"] as! String
                let message = data["message"] as? String ?? ""
                self.showErrorAlert(title: title, message: message)
            }
            else {
                let userData = data["user"] as! [String:Any]
                let user = User.init()
                user.id = userData["id"] as? Int ?? 0
                user.name = userData["name"] as? String ?? ""
                user.email = userData["email"] as? String ?? ""
                user.address = userData["address"] as? String ?? ""
                user.dateOfBirth = userData["dob"] as? String ?? ""
                user.userType = userData["userType"] as? Int ?? 1
                user.isActice = userData["isActive"] as? Bool ?? true

                Globals.sharedInstance.user = user
                Globals.sharedInstance.userToken = data["token"] as? String ?? ""
                
                if (user.isActice!) {
                    if user.userType == 2 {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(identifier: "AdminViewController")
                        
                            self.navigationController?.setViewControllers([vc], animated: true)
                    }
                    else {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(identifier: "tabController")
                    
                        self.navigationController?.setViewControllers([vc], animated: true)
                    }
                }
                else {
                    //Show popup that user is blocked
                    self.showErrorAlert(title: "Error", message: "User is Blocked")
                }
            }
//            user.name = data["name"] as? String ?? "";
            
            
        }) { (error) in
            print(error)
        }
        
    }
    
}
