//
//  NavigationController.swift
//  CoreData
//
//  Created by Fedor Boriskin on 11.01.2022.
//

import Foundation
import UIKit

class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        self.setViewControllers([ViewController()], animated: true)
    }
    
}


