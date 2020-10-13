//
//  UserDocsResponse.swift
//  OnlyOfficeTest
//
//  Created by Мария Матичина on 10/12/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import ObjectMapper

struct UserDocsResponse: Mappable {
    
    var status: Int?
    var response: UserDocsResult?
    
    init() { }
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        response <- map["response"]
        status <- map["status"]
    }
}
