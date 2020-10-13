//
//  ProfileResponse.swift
//  OnlyOfficeTest
//
//  Created by Мария Матичина on 10/9/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import Foundation
import ObjectMapper

struct ProfileResponse: Mappable {
    
    var response: ProfileResult?
    
    init() { }
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        response <- map["response"]
    }
}
