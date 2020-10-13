//
//  UserDocsResult.swift
//  OnlyOfficeTest
//
//  Created by Мария Матичина on 10/12/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import ObjectMapper

struct UserDocsResult: Mappable {
    
    var files: [File] = []
    var folders: [Folder] = []
    
    init() { }
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        files <- map["files"]
        folders <- map["folders"]
    }
}
