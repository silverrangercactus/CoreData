//
//  SecondNabigationController.swift
//  CoreData
//
//  Created by Fedor Boriskin on 28.01.2022.
//

import UIKit

class SecondNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setViewControllers([HomeViewController()], animated: true)
    }
    


}
