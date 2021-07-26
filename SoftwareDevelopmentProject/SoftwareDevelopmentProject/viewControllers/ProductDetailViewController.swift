//
//  ProductDetailViewController.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/4/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit
import SDWebImage

class ProductDetailViewController: BaseViewController {

    var id: Int?
    var product = Product()
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var uploadedBy: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    
    @IBOutlet weak var messageBtn: UIButton!
    
    @IBOutlet weak var markAsSoldBtn: UIButton!
    
    
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
                }
                
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
        price.text = "$ \(product.price!)"
        productCategory.text = Globals.sharedInstance.getCategoryName(id: product.categoryID!)
        
        if product.ownerID! == Globals.sharedInstance.user!.id! {
            self.markAsSoldBtn.isHidden = false
        }
        else {
            self.markAsSoldBtn.isHidden = true
        }
        
        
        imagesCollectionView.reloadData()
    }
    
    
    @IBAction func markAsSold(_ sender: Any) {
        
    }

}


extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
            cell.bannerImage.sd_setImage(with: URL(string: RestApiManager.sharedInstance.baseURL+product.images[indexPath.item].image!.replacingOccurrences(of: " ", with: "%20")), placeholderImage: UIImage(named: "placeholder"))
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
