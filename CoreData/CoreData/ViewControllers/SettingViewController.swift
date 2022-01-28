//
//  SettingViewController.swift
//  CoreData
//
//  Created by Fedor Boriskin on 25.01.2022.
//

import UIKit

protocol ReloadDataDelegate: AnyObject {
    func reloadData()
}

class SettingViewController: UIViewController {
    
    weak var dataReload: ReloadDataDelegate?
    
    var sortLabel: UILabel = {
        let sortLabel = UILabel()
        sortLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        sortLabel.textColor = .black
        sortLabel.text = "Сортировка файлов"
        return sortLabel
    }()
    
    var sortSwitch: UISwitch = {
        let sortSwitch = UISwitch()
        sortSwitch.backgroundColor = .red
        sortSwitch.layer.masksToBounds = true
        sortSwitch.layer.cornerRadius = 16
        sortSwitch.addTarget(self, action: #selector(sortedDocNames), for: .valueChanged)
        return sortSwitch
    }()
    
    var passChangeButton: UIButton = {
        let passChangeButton = UIButton()
        passChangeButton.setTitle("Change password", for: .normal)
        passChangeButton.backgroundColor = .systemPurple
        passChangeButton.layer.masksToBounds = true
        passChangeButton.layer.borderWidth = 0.5
        passChangeButton.layer.cornerRadius = 10
        passChangeButton.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        return passChangeButton
    }()
    
    @objc func changePassword() {
        let changePassVC = HomeViewController()
        present(changePassVC, animated: true, completion: nil)
        changePassVC.homeButton.setTitle("Изменить пароль", for: .normal)
        changePassVC.passwordTextField.placeholder = "Enter the new password"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .white
        sortSwitch.isOn = UserSetting.sortFilterDocNames 
        setupUI()
    }
    
    
    @objc func sortedDocNames() {
        if sortSwitch.isOn {
            UserSetting.sortFilterDocNames = true
            dataReload?.reloadData()
        } else {
            UserSetting.sortFilterDocNames = false
            dataReload?.reloadData()
        }
    }
    
    private func setupUI() {
        view.addSubview(sortLabel)
        view.addSubview(sortSwitch)
        view.addSubview(passChangeButton)
        
        sortLabel.translatesAutoresizingMaskIntoConstraints = false
        sortSwitch.translatesAutoresizingMaskIntoConstraints = false
        passChangeButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            sortLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            sortLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sortLabel.heightAnchor.constraint(equalToConstant: 30),
            sortLabel.trailingAnchor.constraint(equalTo: sortSwitch.leadingAnchor),
            
            sortSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            sortSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            passChangeButton.topAnchor.constraint(equalTo: sortLabel.bottomAnchor, constant: 16),
            passChangeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passChangeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passChangeButton.heightAnchor.constraint(equalToConstant: 50),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
