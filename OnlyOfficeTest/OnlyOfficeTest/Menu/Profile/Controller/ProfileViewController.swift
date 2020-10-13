//
//  ProfileViewController.swift
//  OnlyOfficeTest
//
//  Created by Мария Матичина on 10/9/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var photoView: WebImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    // MARK: - Properties
    
    private var networkingService = NetworkingService.shared
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.layer.cornerRadius = 4.0
        logoutButton.layer.masksToBounds = true
        photoView.layer.cornerRadius = photoView.frame.size.width / 2
        
        getProfile()
    }
    
    
    // MARK: - Networking
    
    func getProfile() {
        networkingService.request(t: ProfileResponse(), api: .profile, method: .get) { [weak self] (resp, error) in
            guard let self = self, let profile = resp?.response else { return }
            
            self.userNameLabel.text = profile.displayName
            
            if let avatar = profile.avatar {
                self.photoView.set(imageURL: avatar)
            }
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func logoutAction(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Auth", bundle:nil)
        let authViewController = storyBoard.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
        authViewController.modalPresentationStyle = .fullScreen
        self.present(authViewController, animated:true, completion:nil)
    }
}
