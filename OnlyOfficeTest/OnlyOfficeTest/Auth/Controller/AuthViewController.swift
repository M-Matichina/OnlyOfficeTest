//
//  AuthViewController.swift
//  OnlyOfficeTest
//
//  Created by Мария Матичина on 10/7/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var portalTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    private var networkingService = NetworkingService.shared
    
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 4.0
        loginButton.layer.masksToBounds = true
        loader.isHidden = true
        
        hideKeyboardWhenTappedAround()
    }
    
    
    // MARK: - Actions
    
    @IBAction func loginTap(_ sender: Any) {
        guard let portal = portalTextField.text, portal.isValidURL() else {
            showError("Поле Portal заполнено неверно.")
            return
        }
        
        guard let email = emailTextField.text, email.isValidEmail() else {
            showError("Поле Email заполнено неверно.")
            return
        }
        
        guard let password = passwordTextField.text, password.count > 3 else {
            showError("Поле Password заполнено неверно.")
            return
        }
        
        auth(portal: portal, email: email, password: password)
    }
    
    
    // MARK: - Networking
    
    func auth(portal: String, email: String, password: String) {
        
        let params = [
            "userName": email,
            "password": password,
        ]
        
        networkingService.portal = portal
        
        loader.isHidden = false
        loader.startAnimating()
        
        networkingService.request(t: AuthResponse(), api: .auth, method: .post, params) { [weak self] (resp, error) in
            guard let self = self else { return }
            
            self.networkingService.token = resp?.response?.token
            self.networkingService.expires = resp?.response?.expires
            
            self.loader.stopAnimating()
            self.loader.isHidden = true
            
            if let error = error {
                self.showError(error.rawValue)
                return
            }
            
            self.switchScreen()
        }
    }
    
    
    // MARK: - Keyboard
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: - Error Alert
    
    func showError(_ message: String) {
        let errorView = UIAlertController(title: "Ошибка!", message: message, preferredStyle: .alert)
        errorView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(errorView, animated: true, completion: nil)
    }
    
    
    // MARK: - Переход на MainTabBarController
    
    func switchScreen() {
        
        guard
            let window = UIApplication.shared.keyWindow,
            let root = UIStoryboard(name:"Menu",
                                    bundle:Bundle.main)
                .instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController
            else { return }
        
        if #available(iOS 13.0, *) {
            window.rootViewController = root
        } else {
            let transition = CATransition()
            transition.type = CATransitionType.fade
            window.set(rootViewController: root, withTransition: transition)
        }
    }
}
