//
//  FileManager+Extension.swift
//  CoreData
//
//  Created by Fedor Boriskin on 13.01.2022.
//

import Foundation

extension FileManager {
   
    static func getDocumentDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory,
                                 in: .userDomainMask)[0]
    }
    
}
