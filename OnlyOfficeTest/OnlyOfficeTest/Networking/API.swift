//
//  API.swift
//  OnlyOfficeTest
//
//  Created by Мария Матичина on 10/7/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import Foundation

enum API: String {
    case auth = "/api/2.0/authentication"
    case userFiles = "/api/2.0/files/@my"
    case commonFiles = "/api/2.0/files/@common"
    case profile = "/api/2.0/people/@self"
}
