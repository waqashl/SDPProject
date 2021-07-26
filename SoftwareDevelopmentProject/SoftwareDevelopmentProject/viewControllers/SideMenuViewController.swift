//
//  SideMenuViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/5/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var menuTableView: UITableView?
    
    let menu = ["Home","Profile","Policy","Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension SideMenuViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as! SideMenuTableViewCell
        
        cell.menuLabel.text = menu[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //perform Actions
        if menu[indexPath.row] == "Home" {
            self.navigationController?.popToRootViewController(animated: true)
        }
        else if menu[indexPath.row] == "Profile" {
            
        }
        else if menu[indexPath.row] == "Policy" {
            
        }
        else if menu[indexPath.row] == "Logout" {
            
            guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
                return
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "loginController")
            
            self.dismiss(animated: false) {
                (rootViewController as? UINavigationController)?.setViewControllers([vc], animated: false)
            }
            
        }
        
    }
    
}
