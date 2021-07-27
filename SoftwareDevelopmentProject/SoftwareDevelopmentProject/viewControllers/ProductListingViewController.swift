//
//  ProductListingViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/4/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit
import PopupDialog
import SDWebImage

class ProductListingViewController: BaseViewController {
    
    
    @IBOutlet weak var productTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var noProductView: UIView!
    
    var products = [Product]()
    var selectedProductID : Int?
    
    //filters
    let sortItems = ["Price-High to Low", "Price-Low to High","Recent First"]
    var categoryID: Int?
    var sortBy: Int?
    var minPrice: Int?
    var maxPrice: Int?
    
//    var applyFilter = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedProductID = nil
        getData()

//        if applyFilter {
//            applyFilter = false
//            getData()
//        }
    }
    
    @IBAction func filterBtnAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "filterViewController") as FilterViewController
        
        vc.hostController = self
        let popup = PopupDialog(viewController: vc, buttonAlignment: .horizontal, transitionStyle: .bounceUp, tapGestureDismissal: true)
        
        vc.popUp = popup
        self.present(popup, animated: true, completion: nil)
    }
    
    
    func getData() {
        var url = "products/?"
        var params = [String:Any]()
        if let search = searchBar.text?.trimmingCharacters(in: .whitespaces) {
//            url += "sq="+searchBar.text!.trimmingCharacters(in: .whitespaces)
            params["sq"] = search
        }
        if categoryID != nil {
            params["cat"] = categoryID!
        }
        if sortBy != nil {
            let sort = sortItems[sortBy!]
            if sort == "Price-High to Low" {
                params["sortT"] = "p"
                params["sortV"] = "desc"
            }
            else if sort == "Price-Low to High" {
                params["sortT"] = "p"
                params["sortV"] = "asc"
            }
            else  {
//                Recent First
                params["sortT"] = "dt"
                params["sortV"] = "desc"
            }
        }
        if minPrice != nil {
            params["pMin"] = minPrice!
        }
        if maxPrice != nil {
            params["pMax"] = maxPrice!
        }
        
//        for (key, value) in params {
//            //params
//            if let temp = value as? String {
//                url += "sq="+searchBar.text!.trimmingCharacters(in: .whitespaces)
//                multiPart.append(temp.data(using: .utf8)!, withName: key)
//            }
//            if let temp = value as? Int {
//                multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
//            }
//        }
//        
        
        
        
        
//        req.query.sq, req.query.cat, req.query.pMin, req.query.pMax, req.query.sortT, req.query.sortV
        RestApiManager.sharedInstance.makeGetRequest(vc: nil, url: url, params: params, successCompletionHandler: { (data) in
            
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
            
            let vc = segue.destination as! ProductDetailViewController
            vc.id = selectedProductID
        }
    }
    
}


extension ProductListingViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if products.count == 0 {
            self.productTable.backgroundView = noProductView
        }
        else {
            self.productTable.backgroundView = nil
        }
        
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductTableViewCell
        let product = products[indexPath.row]
        
        cell.productTitle.text = product.title
        cell.productPrice.text = "€ \(product.price!)"
        cell.productDescription.text = product.description!
        cell.uploadedBy.text = product.ownerName!
        
        if product.thumbnailImage != nil {
            cell.productImage.sd_setImage(with: URL(string: products[indexPath.row].getThumbnailURL()), placeholderImage: UIImage(named: "placeholder"))
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



extension ProductListingViewController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel")
        getData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search")
        searchBar.resignFirstResponder()
        getData()
    }
}
