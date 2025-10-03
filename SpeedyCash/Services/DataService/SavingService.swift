//
//  SavingService.swift
//  YourLucky
//
//  Created by MacBook on 10.07.2023.
//

import Foundation

protocol Saveable {
    func saveData<T: Codable>(encodeData: T, key: String)
    func retrieveData<T: Codable>(key: String) -> T?
}

class SavingService: Saveable {
    
     func saveData<T: Codable>(encodeData: T, key: String) {
        let encoder = JSONEncoder()
           if let encoded = try? encoder.encode(encodeData) {
               UserDefaults.standard.set(encoded, forKey: key)
           }
         print("save")
    }
    
     func retrieveData<T: Codable>(key: String) -> T? {
         if let data = UserDefaults.standard.data(forKey: key) {
             do {
                 let decoder = JSONDecoder()
                 let loadedData = try decoder.decode(T.self, from: data)
                 print("return")

                 return loadedData
             } catch {
                 print("Unable to Decode Favorite items (\(error))")
                 return nil
             }
         }
         return nil
    }
}
