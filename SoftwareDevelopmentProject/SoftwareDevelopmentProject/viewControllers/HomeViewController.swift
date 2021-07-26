//
//  HomeViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/4/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var products = [Product]()
    var categoryProducts = [Int: [Product]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Home"
        
        Globals.sharedInstance.getCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        getData()
    }
    
    
    func getData() {
    RestApiManager.sharedInstance.makeGetRequest(vc: self, url: "products/", params: nil, successCompletionHandler: { (data) in
        
        guard let data = data as? [String: Any] else { return }
        if (data["status"] as! String == "Success") {
            
            let product = data["products"] as! [Any]
            
            for p in product {
                let productData = p as! [String:Any]
                
                let newProduct = Product()
                newProduct.id = productData["id"] as? Int ?? 0
                newProduct.title = productData["title"] as? String ?? ""
                newProduct.price = productData["price"] as? Double ?? 0.0
                newProduct.description = productData["desc"] as? String ?? ""
                newProduct.categoryID = productData["category"] as? Int ?? 0
                newProduct.thumbnailImage = productData["thumbnail"] as? String ?? ""
                newProduct.date = productData["createdAt"] as? String ?? ""
                newProduct.ownerName = productData["name"] as? String ?? ""
                
                self.products.append(newProduct)
            }
            
            self.categorizeProduct()
        }
    }) { (err) in
        print(err)
    }
    }
    
    
    func categorizeProduct() {
        for p in products {
            if categoryProducts.keys.contains(p.categoryID!) {
                categoryProducts[p.categoryID!]!.append(p)
            }
            else {
                categoryProducts[p.categoryID!] = [p]
            }
        }
        
        self.tableView!.reloadData()
    }
    
    
}



extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : categoryProducts.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "carouselTableCell") as! CarouselTableViewCell
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeProductsCell") as! HomeProductsTableViewCell
            let keys = Array(categoryProducts.keys)
            let p = categoryProducts[keys[indexPath.row]]
            
            cell.categoryName.text = Globals.sharedInstance.getCategoryName(id: keys[indexPath.row])
            
            cell.products = p!
            
            cell.viewAllBtn.tag = indexPath.row
            cell.viewAllBtn.addTarget(self, action: #selector(viewAllBtnAction(_:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    @objc func viewAllBtnAction(_ sender: UIButton) {
//        productlistingSegue
        performSegue(withIdentifier: "productlistingSegue", sender: nil)
    }
    
}
