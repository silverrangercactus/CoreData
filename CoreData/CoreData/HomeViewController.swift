//
//  HomeViewController.swift
//  CoreData
//
//  Created by Fedor Boriskin on 25.01.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: passwordTextField.frame.height))
        passwordTextField.leftView = paddingView
        passwordTextField.leftViewMode = UITextField.ViewMode.always
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.placeholder = "Enter the password"
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    
    var homeButton: UIButton = {
        let homeButton = UIButton()
        homeButton.setTitle("Button", for: .normal)
        homeButton.backgroundColor = .systemBlue
        homeButton.layer.masksToBounds = true
        homeButton.layer.borderWidth = 0.5
        homeButton.layer.cornerRadius = 10
        return homeButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(passwordTextField)
        view.addSubview(homeButton)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            homeButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            homeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeButton.heightAnchor.constraint(equalToConstant: 50),
            homeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            homeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
           
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
