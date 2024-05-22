//
//  UserDefaultManager.swift
//  mediafinder
//
//  Created by ALY NABIL on 21/05/2024.
//

import Foundation

class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    
    func saveUserData(userData: User) {
        do {
            let encoder = JSONEncoder()
            let encoderData = try encoder.encode(userData)
            userDefaults.set(encoderData, forKey: "userData")
        } catch {
            print("Error encoding user data: \(error.localizedDescription)")
        }
    }
    func loadUserData() -> User? {
        if let saveData = userDefaults.data(forKey: "userData") {
            do {
                let decoder = JSONDecoder()
                let decodedUserData = try decoder.decode(User.self,from: saveData)
                return decodedUserData
            } catch {
                print("Error decoding user data: \(error.localizedDescription)")
            }
        }
        return nil
    }
}
