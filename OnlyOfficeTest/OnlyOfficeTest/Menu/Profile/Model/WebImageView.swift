//
//  WebImageView.swift
//  OnlyOfficeTest
//
//  Created by Мария Матичина on 10/12/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import Foundation
import UIKit

class WebImageView: UIImageView {
    
    func set(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    self?.image = UIImage(data: data)
                }
            }
        }
        dataTask.resume()
    }
}
