//
//  UserProfileViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/26/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit

class UserProfileViewController: BaseViewController {

    
    var user = Globals.sharedInstance.user!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
        // Do any additional setup after loading the view.
    }
    
    
    func setData() {
        nameLabel.text = user.name!
        emailLabel.text = user.email!
        addressLabel.text = user.address!
        dobLabel.text = user.getFormattedData()
    }

    

}
