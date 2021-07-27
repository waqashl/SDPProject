//
//  SideMenuViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/5/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var menu = ["Profile","Policy","Logout"]
    var images = ["userIcon","comment","logout"]
        
//    let userMenuItems = ["Profile","Policy","Logout"]
//    let userMenuimages = ["userIcon","comment","logout"]
//
//    let adminMenuItems = ["Profile","Policy","Logout"]
//    let adminMenuimages = ["userIcon","comment","logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if Globals.sharedInstance.user.id! == 1 {
//            menu = userMenuItems
//            images = userMenuImages
//        }
//        else {
//            menu = adminMenuItems
//            images = adminMenuimages
//        }
        
        menuTableView.reloadData()

        self.userNameLabel.text = Globals.sharedInstance.user!.name!
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
        cell.menuIcon.image = UIImage.init(named: images[indexPath.row])
        
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
            self.performSegue(withIdentifier: "profileSegue", sender: nil)
        }
        else if menu[indexPath.row] == "Policy" {
//            policySegue
            self.performSegue(withIdentifier: "policySegue", sender: nil)
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
