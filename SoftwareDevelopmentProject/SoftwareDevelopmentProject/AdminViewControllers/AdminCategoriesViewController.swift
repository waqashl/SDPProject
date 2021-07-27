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
        
        vc.delegate = self
        let popup = PopupDialog(viewController: vc, buttonAlignment: .horizontal, transitionStyle: .bounceUp, tapGestureDismissal: true)
        
        vc.popUp = popup
        self.present(popup, animated: true, completion: nil)
    }
    
    
    func removeCategory(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ConfirmationAlertViewController") as ConfirmationAlertViewController
        vc.delegate = self
        vc.indexPath = indexPath
        
        vc.title = "Delete"
        vc.message = "Are you sure you want to delete this category?"
        
        let popup = PopupDialog(viewController: vc, buttonAlignment: .horizontal, transitionStyle: .bounceUp, tapGestureDismissal: true)
        
        vc.popUp = popup
        self.present(popup, animated: true, completion: nil)
    }
    
    func deleteCategory(indexPath: IndexPath) {
        let param = ["categoryId":categories[indexPath.row].id!]
        let url = "category/delete"
        
        RestApiManager.sharedInstance.makePostRequest(vc: self, url: url, params: param, successCompletionHandler: { (data) in
            
            self.showErrorAlert(title: "Success", message: "Category Deleted.", delegate: self)
                        
        }) { (err) in
            print(err)
        }
    }
    
}


extension AdminCategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryTableViewCell
        
        cell.categoryName.text = categories[indexPath.row].name
        cell.categoryStatus.text = categories[indexPath.row].isActive! ? "Active" : "Deleted"
        cell.categoryStatus.textColor = categories[indexPath.row].isActive! ? UIColor.systemGreen : UIColor.systemRed
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return categories[indexPath.row].isActive!
    }
    
    
    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // remove the item from the data model
            removeCategory(indexPath: indexPath)
        }
        
    }
}


extension AdminCategoriesViewController: ErrorAlertDelegates {
    
    func okPressed() {
        self.getCategories()
    }
}

extension AdminCategoriesViewController: ConfirmationAlertDelegates {
    
    func confirmPressed(indexPath: IndexPath) {
        self.deleteCategory(indexPath: indexPath)
    }
    
    func cancelPressed() {
        //
    }
    
}
