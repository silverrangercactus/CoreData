//
//  HomeViewController.swift
//  CoreData
//
//  Created by Fedor Boriskin on 25.01.2022.
//

import UIKit
import KeychainAccess

class HomeViewController: UIViewController {
    
    let appCoordinator = AppCoordinaor()
    
    let minPasswordCount = 4
    
    let keychain = Keychain(service: "myApp")
    
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
        homeButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return homeButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(keychain["user"])
        print(keychain["userCheck"])
//        print(Keychain(service: "myApp").allKeys())
//        print(keychain["user"])
//        keychain["user"] = nil
//        keychain["userCheck"] = nil
        setupUI()
        
        if keychain["user"] == nil {
            homeButton.setTitle("Создать пароль", for: .normal)
        } else {
            homeButton.setTitle("Ввести пароль", for: .normal)
        }
        
    }
    
    @objc func buttonTapped() {
        if passwordTextField.text == "" {
            print("поле пустое")
            
        } else if passwordTextField.text?.count ?? 0 < minPasswordCount && keychain["user"] == nil {
            print("минимум 4 цифры")
            
        } else if let passwordStep1 = passwordTextField.text,
                                      keychain["user"] == nil,
                                    keychain["userCheck"] == nil {
                homeButton.setTitle("Повторите пароль", for: .normal)
                passwordTextField.text = ""
                keychain["userCheck"] = passwordStep1
            
        } else if let passwordStep2 = passwordTextField.text,
                                      keychain["userCheck"] != nil, keychain["user"] == nil  {
            if passwordStep2 == keychain["userCheck"] {
                keychain["user"] = passwordStep2
                keychain["userCheck"] = nil
                passwordTextField.text = ""
                print("пароль сохранен")
                
            } else {
                print("пароли не совпадют")
                passwordTextField.text = ""
                keychain["userCheck"] = nil
                homeButton.setTitle("Создать пароль", for: .normal)
            }
            
        } else if passwordTextField.text == keychain["user"] && keychain["userCheck"] == nil {
                print("Вы зашли")
                pushVC()
            
        } else if passwordTextField.placeholder == "Enter the new password" {
            keychain["user"] = passwordTextField.text
            print("Пароль изменен")
            dismiss(animated: true, completion: nil)
            
        } else {
            if passwordTextField.text != keychain["user"]  {
                print("неверный пароль")
            }
        }
    }
    
    private func pushVC() {
        let newVC = appCoordinator.mainViewController
        
        navigationController?.pushViewController(newVC, animated: true)
        navigationController?.isNavigationBarHidden = true
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
