//
//  ChatViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/7/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit

class ChatViewController: BaseViewController {

    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextView: UITextView!
    
    
    var currentUserId = 1;
    var messages = [1,1,1,1,2,2,1,2,1,2,1,2,2,2,1,2,1,1,2,2]
    var message = ["ABCDEFGHI GKLM NOPQRST UVWX Y Z 1234 5678 901","Hello","Hello World"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendMessgeBtn(_ sender: UIButton) {
        
    }

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if currentUserId == messages[indexPath.row] {
            let cell = tableView.dequeueReusableCell(withIdentifier: "senderCell") as! SenderTableViewCell
            
            cell.userName.text = "Huzaifa"
            cell.message.text = message[indexPath.row % 3]
            
            if (messages.count-1 == indexPath.row) {
                cell.imageNameView.isHidden = false
            }
            else {
                cell.imageNameView.isHidden = messages[indexPath.row] == messages[indexPath.row+1]
            }
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recepientCell") as! RecipientTableViewCell
            
            cell.userName.text = "Waqas"
            cell.message.text = message[indexPath.row % 3]

            if (messages.count-1 == indexPath.row) {
                cell.imageNameView.isHidden = false
            }
            else {
                if (messages[indexPath.row] == messages[indexPath.row+1]) {
                    cell.imageNameView.isHidden = true
                    cell.imageNameView.frame.size.height = 0
                }
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
