//
//  Product.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/7/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import Foundation


class Product {
    
    var id: Int?
    var title: String?
    var price: Double?
    var description: String?
    var categoryID: Int?
    var images = [ProductImage]()
    var thumbnailImage: String?
    var date: String?
    var ownerName: String?
    var ownerID: Int?
    var status: Int?
    
    init(){
    }
    
}


class ProductImage {
    
    var id: Int?
    var productId: Int?
    var image: String?
    
    init(){
    }
    
}
//
//
//class Filter {
//    var search = ""
//    var categoryID : Int?
//    var minPrice = 0
//    var max
//}
