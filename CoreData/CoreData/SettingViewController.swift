//
//  SettingViewController.swift
//  CoreData
//
//  Created by Fedor Boriskin on 25.01.2022.
//

import UIKit


enum SortedNames {
    case sorted, unsorted
}

class SettingViewController: UIViewController {
    
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
        return passChangeButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .white
        
        setupUI()
    }
    
    
    @objc func sortedDocNames() {
        if sortSwitch.isOn {
            view.backgroundColor = .green
        } else {
            view.backgroundColor = .blue
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
