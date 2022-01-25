//
//  DocumentsFlowCoordinator.swift
//  CoreData
//
//  Created by Fedor Boriskin on 25.01.2022.
//

import UIKit

final class DocumentsFlowCoordinator: Coordinator {
   
    var coordinators: [Coordinator] = []
    let navigationController: UINavigationController
    private let factory: ControllerFactory
    
    init(navigationController: UINavigationController, factory: ControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    func start() {
        let documentVC = factory.makeDocumentsVC()
        navigationController.pushViewController(documentVC, animated: true)
    }
    
}
