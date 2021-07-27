//
//  AdminProductReviewViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/5/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit
import SDWebImage

class AdminProductReviewViewController: BaseViewController {
    
    var id: Int?
    var product = Product()
    
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var uploadedBy: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var statusLabel : UILabel!
    @IBOutlet weak var productLocation: UILabel!
    
    @IBOutlet weak var approveBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageController.hidesForSinglePage = true
        getData()
    }
    
    
    func getData() {
        RestApiManager.sharedInstance.makeGetRequest(vc: self, url: "products/?id=\(self.id!)", params: nil, successCompletionHandler: { (data) in
            
            guard let data = data as? [String: Any] else { return }
            if (data["status"] as! String == "Success") {
                
                let product = data["products"] as! [Any]
                let images = data["productImages"] as! [Any]
                
                for p in product {
                    let productData = p as! [String:Any]
                    
                    self.product.id = productData["id"] as? Int ?? 0
                    self.product.title = productData["title"] as? String ?? ""
                    self.product.price = productData["price"] as? Double ?? 0.0
                    self.product.description = productData["desc"] as? String ?? ""
                    self.product.categoryID = productData["category"] as? Int ?? 0
                    self.product.thumbnailImage = productData["thumbnail"] as? String ?? ""
                    self.product.date = productData["createdAt"] as? String ?? ""
                    self.product.ownerName = productData["ownerName"] as? String ?? ""
                    self.product.status = productData["status"] as? Int ?? 0
                    self.product.location = productData["location"] as? String ?? ""
                }
                
                self.product.images.removeAll()
                
                for i in images {
                    let image = i as! [String: Any]
                    var productImage = ProductImage()
                    productImage.id = image["id"] as? Int ?? 0
                    productImage.productId = image["productId"] as? Int ?? 0
                    productImage.image = image["image"] as? String ?? ""
                    
                    self.product.images.append(productImage)
                }
                
                self.setData()
            }
            
        }) { (err) in
            print(err)
        }
    }
    
    
    func setData() {
        productTitle.text = product.title!
        productDescription.text = product.description!
        uploadedBy.text = product.ownerName!
        price.text = "€ \(product.price!)"
        productLocation.text = product.location!
        
        if product.status == 0 {
            statusLabel.text = "Pending"
            statusLabel.textColor = UIColor.orange
            approveBtn.isUserInteractionEnabled = true
            rejectBtn.isUserInteractionEnabled = true
            approveBtn.isEnabled = true
            rejectBtn.isEnabled = true
            approveBtn.alpha = 1.0
            rejectBtn.alpha = 1.0
        }
        else if product.status == 1 {
            statusLabel.text = "Approved"
            statusLabel.textColor = UIColor.systemGreen
            approveBtn.isUserInteractionEnabled = false
            rejectBtn.isUserInteractionEnabled = true
            approveBtn.isEnabled = false
            rejectBtn.isEnabled = true
            approveBtn.alpha = 0.5
            rejectBtn.alpha = 1.0
        }
        else if product.status == 2 {
            statusLabel.text = "Rejected"
            statusLabel.textColor = UIColor.systemRed
            approveBtn.isUserInteractionEnabled = true
            rejectBtn.isUserInteractionEnabled = false
            approveBtn.isEnabled = true
            rejectBtn.isEnabled = false
            approveBtn.alpha = 1.0
            rejectBtn.alpha = 0.5
        }
        else {
            statusLabel.text = "Sold"
            statusLabel.textColor = UIColor.systemBlue
            approveBtn.isUserInteractionEnabled = false
            rejectBtn.isUserInteractionEnabled = false
            approveBtn.isEnabled = false
            rejectBtn.isEnabled = false
            approveBtn.alpha = 0.5
            rejectBtn.alpha = 0.5
        }
        
        productCategory.text = Globals.sharedInstance.getCategoryName(id: product.categoryID!)
    
        imagesCollectionView.reloadData()
    }
    
    
    @IBAction func acceptBtnAction(_ sender: Any) {
//        approve
//        /update/status
        
        let param = ["id":self.id! ,"status":"approve"] as [String : Any]

        RestApiManager.sharedInstance.makePostRequest(vc: self, url: "products/update/status", params: param, successCompletionHandler: { (data) in
            
            self.showErrorAlert(title: "Success", message: "Product Approved", delegate: nil)
            self.getData()

        }) { (err) in
            print(err)
        }
        
        
    }
    
    @IBAction func rejectBtnAction(_ sender: Any) {
//        /update/status
        let param = ["id":self.id! ,"status":"reject"] as [String : Any]
        
        RestApiManager.sharedInstance.makePostRequest(vc: self, url: "products/update/status", params: param, successCompletionHandler: { (data) in
            
            self.showErrorAlert(title: "Success", message: "Product Rejected", delegate: nil)

            self.getData()
            
        }) { (err) in
            print(err)
        }
    }
    
}


extension AdminProductReviewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        self.pageController.numberOfPages = product.images.count == 0 ? 1 : product.images.count
        return product.images.count == 0 ? 1 : product.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCollectionCell", for: indexPath) as! CarouselCollectionViewCell
        
        if product.images.count == 0 {
            cell.bannerImage.image = UIImage.init(named: "placeholder")
        }
        else {
            cell.bannerImage.sd_setImage(with: URL(string: product.images[indexPath.item].getImageURL()), placeholderImage: UIImage(named: "placeholder"))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width  = collectionView.frame.size.width
        return CGSize.init(width: width, height: 200.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageController.currentPage = indexPath.row
    }
    
}
