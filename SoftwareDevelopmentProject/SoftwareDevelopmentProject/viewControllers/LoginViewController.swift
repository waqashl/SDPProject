//
//  LoginViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/4/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField?
    @IBOutlet weak var userPassword: UITextField?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //userLoginSegue
    //adminLoginSegue
    @IBAction func loginBtnAction(_ sender: Any) {
        
        if userEmail!.text == "admin" {
            self.performSegue(withIdentifier: "adminLoginSegue", sender: nil)
        }
        else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "tabController")
            
            self.navigationController?.setViewControllers([vc], animated: true)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adminLoginSegue" {
            
        }
        else {
            
        }
    }
    
}
