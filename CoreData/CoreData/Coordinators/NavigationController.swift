//
//  NavigationController.swift
//  CoreData
//
//  Created by Fedor Boriskin on 11.01.2022.
//

import UIKit

class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        self.setViewControllers([DocumentsViewController()], animated: true)
    }
    
}


