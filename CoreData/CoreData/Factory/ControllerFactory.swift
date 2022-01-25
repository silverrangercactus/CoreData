//
//  ControllerFactory.swift
//  CoreData
//
//  Created by Fedor Boriskin on 25.01.2022.
//

import UIKit

protocol ControllerFactory {
    func makeDocumentsVC() -> DocumentsViewController
}

struct ControllerFatoryImpl: ControllerFactory {
    
    func makeDocumentsVC() -> DocumentsViewController {
        let documentsVC = DocumentsViewController()
        return documentsVC
    }

}
