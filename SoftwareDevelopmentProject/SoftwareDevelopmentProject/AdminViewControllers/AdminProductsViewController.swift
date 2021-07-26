//
//  AdminProductsViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/5/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit
import SDWebImage

class AdminProductsViewController: BaseViewController {
    
    @IBOutlet weak var productTable: UITableView!
    
    
    var products = [Product]()
    var selectedProductID : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        selectedProductID = nil
        getData()
    }
    
    
    
    
    func getData() {
        let url = "products/all"
        
        
        RestApiManager.sharedInstance.makeGetRequest(vc: self, url: url, params: nil, successCompletionHandler: { (data) in
            
            guard let data = data as? [String: Any] else { return }
            if (data["status"] as! String == "Success") {
                
                let product = data["products"] as! [Any]
                self.products.removeAll()
                
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
                    newProduct.status = productData["status"] as? Int ?? 0
                    
                    self.products.append(newProduct)
                }
                
                self.productTable.reloadData()
            }
            
            
        }) { (err) in
            print(err)
        }
        
    }
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productDetailSegue" {
            
            let vc = segue.destination as! AdminProductReviewViewController
            vc.id = selectedProductID
        }
    }
    
}


extension AdminProductsViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductTableViewCell
        let product = products[indexPath.row]
        
        cell.productTitle.text = product.title
        cell.productPrice.text = "€ \(product.price!)"
        cell.productDescription.text = product.description!
        cell.uploadedBy.text = product.ownerName!
        
        if product.status == 0 {
            cell.statusLabel.text = "Pending"
            cell.statusLabel.textColor = UIColor.orange
        }
        else if product.status == 1 {
            cell.statusLabel.text = "Approved"
            cell.statusLabel.textColor = UIColor.systemGreen
        }
        else if product.status == 2 {
            cell.statusLabel.text = "Rejected"
            cell.statusLabel.textColor = UIColor.systemRed
        }
        else {
            cell.statusLabel.text = "Sold"
            cell.statusLabel.textColor = UIColor.systemBlue
        }
        
        if product.thumbnailImage != nil {
            cell.productImage.sd_setImage(with: URL(string: RestApiManager.sharedInstance.baseURL+product.thumbnailImage!), placeholderImage: UIImage(named: "placeholder"))
        }
        else {
            cell.productImage.image = UIImage.init(named: "placeholder")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedProductID = products[indexPath.row].id!
        performSegue(withIdentifier: "productDetailSegue", sender: nil)
        
    }
    
}
