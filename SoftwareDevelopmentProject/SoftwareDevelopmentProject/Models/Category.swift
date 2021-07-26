//
//  Category.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/7/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import Foundation

class Category {

    var id: Int?
    var name: String?
    var isActive: Bool?
    
    init(id:Int, name:String, isActive:Bool) {
        self.id = id
        self.name = name
        self.isActive = isActive
    }
    
}
