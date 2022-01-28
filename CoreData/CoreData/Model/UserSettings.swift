//
//  UserSettings.swift
//  CoreData
//
//  Created by Fedor Boriskin on 28.01.2022.
//

import Foundation

final class UserSetting {
    
    static var sortFilterDocNames: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "sort")
        } set {
            let defaults = UserDefaults.standard
            let sortSwitch = newValue
            defaults.set(sortSwitch, forKey: "sort")
        }
    }
    
}
