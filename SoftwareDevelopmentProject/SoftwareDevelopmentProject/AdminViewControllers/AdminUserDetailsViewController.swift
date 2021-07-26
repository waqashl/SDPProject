//
//  AdminUserDetailsViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/5/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit

class AdminUserDetailsViewController: BaseViewController {

    
    var user: User?
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var blockBtn: UIButton!
    @IBOutlet weak var unBlockBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
    }
    
    func setData() {
        nameLabel.text = user?.name!
        emailLabel.text = user?.email!
        addressLabel.text = user?.address!
        dobLabel.text = user?.getFormattedData()
    }
    
    @IBAction func blockUserAction(_ sender: Any) {
        let param = ["id":self.user!.id! ,"status":"block"] as [String : Any]

        RestApiManager.sharedInstance.makePostRequest(vc: self, url: "user/update/status", params: param, successCompletionHandler: { (data) in
            
            self.showErrorAlert(title: "Success", message: "User Blocked")

        }) { (err) in
            print(err)
        }
    }
    
    @IBAction func unblockUserAction(_ sender: Any) {
        let param = ["id":self.user!.id! ,"status":"unblock"] as [String : Any]

        RestApiManager.sharedInstance.makePostRequest(vc: self, url: "user/update/status", params: param, successCompletionHandler: { (data) in
            
            self.showErrorAlert(title: "Success", message: "User Un-Blocked")

        }) { (err) in
            print(err)
        }
    }

}
