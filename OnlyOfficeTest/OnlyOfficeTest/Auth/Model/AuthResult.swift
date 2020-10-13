//
//  AuthResult.swift
//  OnlyOfficeTest
//
//  Created by Мария Матичина on 10/7/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import ObjectMapper

struct AuthResult: Mappable {
    
    var token: String?
    var expires: String?
    
    init() { }
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
         token <- map["token"]
         expires <- map["expires"]
    }
}
