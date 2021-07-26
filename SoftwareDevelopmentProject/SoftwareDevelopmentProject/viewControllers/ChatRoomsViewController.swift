//
//  ChatRoomsViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/5/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit

class ChatRoomsViewController: BaseViewController {

    @IBOutlet weak var chatRoomTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension ChatRoomsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatRoomCell") as! ChatRoomTableViewCell
        
        cell.productImage.backgroundColor = UIColor.random
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "chatSegue", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
