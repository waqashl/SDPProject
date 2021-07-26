//
//  HomeProductsTableViewCell.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/5/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import UIKit
import SDWebImage

class HomeProductsTableViewCell: UITableViewCell {

    
//    homeProductsCell  -- identifier
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var viewAllBtn: UIButton!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    var products = [Product]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.productsCollectionView.dataSource = self
//        self.productsCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//extension HomeProductsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return products.count > 5 ? 5 : products.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionCell", for: indexPath) as! ProductCollectionViewCell
//
//        cell.productPrice.text = "€ \(products[indexPath.item].price!)"
//        cell.productTitle.text = products[indexPath.item].title!
//        if products[indexPath.row].thumbnailImage != nil {
//            cell.productImage.sd_setImage(with: URL(string: RestApiManager.sharedInstance.baseURL+products[indexPath.row].thumbnailImage!), placeholderImage: UIImage(named: "placeholder"))
//        }
//        else {
//            cell.productImage.image = UIImage.init(named: "placeholder")
//        }
//
//
//
//        return cell
//    }
//
//}
