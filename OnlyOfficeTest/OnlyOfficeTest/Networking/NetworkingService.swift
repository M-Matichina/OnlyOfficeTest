//
//  NetworkingService.swift
//  OnlyOfficeTest
//
//  Created by Мария Матичина on 10/7/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class NetworkingService: NSObject {
    
    // MARK: - Properties
    
    static let shared = NetworkingService()
    private var manager = Alamofire.Session()
    
    var portal: String? {
        get {
            return UserDefaults.standard.value(forKey: "user.portal") as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "user.portal")
        }
    }
    
    var token: String? {
        get {
            return UserDefaults.standard.value(forKey: "user.token") as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "user.token")
        }
    }
    
    var expires: String? {
        get {
            return UserDefaults.standard.value(forKey: "user.expires") as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "user.expires")
        }
    }
    
    var isAuthorized: Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
        
        guard let _ = self.token, let expires = self.expires, let dateExpires = dateFormatter.date(from: expires) else {
            return false
        }
        
        return dateExpires > Date()
    }
    
    
    // MARK: - Functions
    
    func request<T:BaseMappable>(t: T, api: API, method: HTTPMethod, _ parameters: [String: Any]? = nil,  _ completion: ((_ result: T?, _ error: NetworkingError?) -> Void)? = nil) {
        
        guard let url = url(api: api) else {
            completion?(nil, .invalidData)
            return
        }
        
        var headers: HTTPHeaders = [:]
        var params: Parameters = [:]
        
        if let token = token {
            headers["Authorization"] = token
        }
        
        if let keys = parameters?.keys {
            for key in keys {
                params[key] = parameters?[key]
            }
        }
        
        self.manager.request(url,
                             method: method,
                             parameters: (params.count == 0) ? nil : params,
                             headers: (headers.count == 0) ? nil : headers).validate().responseData { (response) in
            switch response.result {
            case .success(let value):
                do {
                    if let json = try JSONSerialization.jsonObject(with: value) as? [String: Any],
                        let result = Mapper<T>().map(JSON: json) {
                        DispatchQueue.main.async {
                            completion?(result, nil)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion?(nil, .invalidData)
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion?(nil, .invalidData)
                    }
                }
            case .failure(let error):
                debugPrint(error)
                DispatchQueue.main.async {
                    completion?(nil, .serverError)
                }
            }
        }
    }
    
    private func url(api: API) -> URL? {
        guard let portal = portal else { return nil }
        return URL(string: portal + api.rawValue)
    }
}
