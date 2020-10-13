//
//  ProfileResult.swift
//  OnlyOfficeTest
//
//  Created by Мария Матичина on 10/9/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import ObjectMapper

struct ProfileResult: Mappable {
    
    var displayName: String?
    var email: String?
    var avatar: String?
    
    init() { }
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        displayName <- map["displayName"]
        email <- map["email"]
        avatar <- map["avatar"]
    }
}
