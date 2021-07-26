//
//  User.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/7/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import Foundation

class User: Decodable {
    
    var id: Int?
    var name: String?
    var dateOfBirth: String?
    var email: String?
    var address: String?
    var userImage: String?
    var userType: Int?
    var isActice: Bool?
    
    public init() {}
    
    
    public func getFormattedData() -> String {
        let d1 = DateFormatter()
        let d2 = DateFormatter()
        
        d1.dateFormat = "MMM dd, yyyy"
        d2.dateFormat = "yyyy-MM-dd"
        
        let d = self.dateOfBirth!.split(separator: "T")
        
        let date = d2.date(from: String(d[0]))
        
        return d1.string(from: date!)
    }
    
}
