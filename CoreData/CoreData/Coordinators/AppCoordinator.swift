//
//  AppCoordinator.swift
//  CoreData
//
//  Created by Fedor Boriskin on 25.01.2022.
//

import Foundation
import UIKit

class AppCoordinaor: Coordinator {
    
    var coordinators: [Coordinator] = []
    let mainViewController: TabBarController
    private let factory = ControllerFatoryImpl()
    
    init() {
        mainViewController = TabBarController()
        
        let documentCoordinator = configureDocumentsVC()
        let settingCoordinator = configurateSettingVC()
        
        mainViewController.viewControllers = [ documentCoordinator.navigationController, settingCoordinator]
        
        documentCoordinator.start()
    }
    
    
    private func configureDocumentsVC() -> DocumentsFlowCoordinator {
        let navigationFirst = UINavigationController()
        navigationFirst.tabBarItem = UITabBarItem(title: "Documents", image: UIImage(systemName: "folder.circle"), selectedImage: nil)
        let coordinator = DocumentsFlowCoordinator(navigationController: navigationFirst, factory: factory)
        return coordinator
    }
    
    private func configurateSettingVC() -> UINavigationController {
        let settingVC = SettingViewController()
        let navigationSecond = UINavigationController(rootViewController: settingVC)
        settingVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "slider.horizontal.3"), selectedImage: nil)
        return navigationSecond
    }
    
}
