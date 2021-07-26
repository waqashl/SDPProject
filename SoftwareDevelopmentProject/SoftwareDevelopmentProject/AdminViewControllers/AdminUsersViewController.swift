//
//  AdminUsersViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/5/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit

class AdminUsersViewController: BaseViewController {

    var users = [User]()

    var selectedUser : User?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        // Do any additional setup after loading the view.
    }
    
    
    
    func getData() {
        
        RestApiManager.sharedInstance.makeGetRequest(vc: self, url: "user/all", params: nil, successCompletionHandler: { (data) in
            
            
            guard let userData = data as? [Any] else { return }
            
            for d in userData {
                let u = d as! [String:Any]
                let user = User()
                user.id = u["id"] as? Int ?? 0
                user.name = u["name"] as? String ?? ""
                user.address = u["address"] as? String ?? ""
                user.userType = u["userType"] as? Int ?? 0
                user.dateOfBirth = u["dob"] as? String ?? ""
                user.email = u["email"] as? String ?? ""
                user.isActice = u["isActive"] as? Bool ?? true
                
                self.users.append(user)
                
            }

            self.tableView.reloadData()
            
            
        }) { (err) in
            print(err)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AdminUserDetailsViewController
        vc.user = selectedUser
    }
    

}


extension AdminUsersViewController : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! UserTableViewCell
        let user = users[indexPath.row]
        
        cell.nameLabel.text = user.name!
        cell.emailLabel.text = user.email!
        cell.addressLabel.text = user.address!
        cell.dobLabel.text = user.getFormattedData()
        cell.statusLabel.text = user.isActice! ? "Active" : "Blocked"
        cell.statusLabel.textColor = user.isActice! ? .systemGreen : .systemRed
        
        cell.userImage.image = UIImage.init(named: "userIcon")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedUser = users[indexPath.row]
        performSegue(withIdentifier: "userDetailSegue", sender: nil)
    }
    
    
    
}
