//
//  Chat.swift
//  SoftwareDevelopmentProject
//
//  Created by Huzaifa on 7/7/21.
//  Copyright © 2021 Technolage. All rights reserved.
//

import Foundation

class ChatRoom {
    
    var id: Int?
    var productId: Int?
    var productImage: String?
    var senderId: Int?
    var receiverId: Int?
    
    var messages: [Chat]?

    init() {
    }
    
}

class Chat {
    
    var id: Int?
    var chatRoomId: Int?
    var senderId: Int?
    var message: String?
    
    init() {
    }
    
}

