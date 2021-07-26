//
//  Globals.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/24/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import Foundation
import UIKit


class Globals {
    
    static let sharedInstance = Globals()

    var user: User?
    var userToken: String?
    
    var categories = [Category]()
    
    var loadingVC = LoadingPartialViewController()
    var showingLoading = false
    
    func showLoading(this: UIViewController){
          if(!showingLoading)
          {
              DispatchQueue.main.async {
                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                  self.loadingVC = storyboard.instantiateViewController(withIdentifier: "LoadingPartial") as! LoadingPartialViewController
                  self.loadingVC.modalPresentationStyle = .custom
                  self.loadingVC.view.backgroundColor = UIColor.black
                  this.present(self.loadingVC, animated: false, completion: nil)
              }
              self.showingLoading = true
          }
      }
      
      func hideLoading()
      {
          self.loadingVC.dismiss(animated: false, completion: nil)
          self.showingLoading = false
      }
    
    func getCategories(){
        RestApiManager.sharedInstance.makeGetRequest(vc: nil, url: "category/", params: nil, successCompletionHandler: { (data) in
            
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
            }
            
        }) { (err) in
            print(err)
        }
    }
    
    
    func getCategoryName(id: Int) -> String {
        for c in categories {
            if c.id == id {
                return c.name!
            }
        }
        return ""
    }
}
