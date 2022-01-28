//
//  Coordinator.swift
//  CoreData
//
//  Created by Fedor Boriskin on 25.01.2022.
//

import Foundation

protocol Coordinator: AnyObject {
    var coordinators: [Coordinator] { get set }
}
