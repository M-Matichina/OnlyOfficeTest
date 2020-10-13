//
//  AuthResponse.swift
//  OnlyOfficeTest
//
//  Created by Мария Матичина on 10/7/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import ObjectMapper

struct AuthResponse: Mappable {
    
    var status: Int?
    var response: AuthResult?
    
    init() { }
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        response <- map["response"]
    }
}
