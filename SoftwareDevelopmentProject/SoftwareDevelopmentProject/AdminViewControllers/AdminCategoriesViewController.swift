//
//  AdminCategoriesViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/5/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit
import PopupDialog

class AdminCategoriesViewController: BaseViewController {

    var categories = [Category]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCategories()
    }
    
    func getCategories(){
        RestApiManager.sharedInstance.makeGetRequest(vc: nil, url: "category/all", params: nil, successCompletionHandler: { (data) in
            
            guard let data = data as? [String: Any] else { return }

            if (data["status"] as? String == "Failed") {
                print("Failed to get categories")
            }
            else {
                let cat = data["categories"] as! [Any]
                self.categories.removeAll()
                for c in cat {
                    let categoryData = c as! [String:Any]
                    self.categories.append(Category.init(id: categoryData["id"] as? Int ?? 0, name: categoryData["name"] as? String ?? "", isActive: categoryData["isActive"] as? Bool ?? true))
                }
                
                print(self.categories.count)
                self.tableView.reloadData()
            }
            
        }) { (err) in
            print(err)
        }
    }
    
    
    @IBAction func addBtnAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "addCategory") as AddNewCategoryViewController
        
        let popup = PopupDialog(viewController: vc, buttonAlignment: .horizontal, transitionStyle: .bounceUp, tapGestureDismissal: true)

        vc.popUp = popup
        self.present(popup, animated: true, completion: nil)
    }

}


extension AdminCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryTableViewCell
        
        cell.categoryName.text = categories[indexPath.row].name
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if (editingStyle == UITableViewCellEditingStyle.Delete) {
//            // handle delete (by removing the data from your array and updating the tableview)
//        }
//    }
}
