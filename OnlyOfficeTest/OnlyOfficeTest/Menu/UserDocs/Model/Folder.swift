//
//  Folder.swift
//  OnlyOfficeTest
//
//  Created by Мария Матичина on 10/12/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//


import ObjectMapper

struct Folder: Mappable {
    
    var title: String?
    var created: String?
    
    init() { }
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        created <- map["created"]
    }
}
