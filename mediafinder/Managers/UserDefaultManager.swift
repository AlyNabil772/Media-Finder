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

    // will call it in MediaVC in Viewdidload to check if user make logInBefor or not
    var isLogedIn: Bool {
        set {
            userDefaults.set(newValue, forKey: "UDKIsLogedIn")
        } get {
            guard userDefaults.object(forKey: "UDKIsLogedIn") != nil else {
                return false
            }
            return userDefaults.bool(forKey: "UDKIsLogedIn")
        }
    }
    // will call it in SignUpVC  check if user make isOpenedBefore or not
    var isOpenedBefore: Bool {
        set {
            userDefaults.set(newValue, forKey: "UDKisOpenedBefore")
        } get {
            guard userDefaults.object(forKey: "UDKisOpenedBefore") != nil else {
                return false
            }
            return userDefaults.bool(forKey: "UDKisOpenedBefore")
        }
    }
}





//
//    func saveUserData(userData: User) {
//        do {
//            let encoder = JSONEncoder()
//            let encoderData = try encoder.encode(userData)
//            userDefaults.set(encoderData, forKey: "userData")
//        } catch {
//            print("Error encoding user data: \(error.localizedDescription)")
//        }
//    }
//    func loadUserData(userData: Data) -> User? {
////        if let saveData = userDefaults.data(forKey: "userData") {
//            do {
//                let decoder = JSONDecoder()
//                let decodedUserData = try decoder.decode(User.self,from: userData)
//                return decodedUserData
//            } catch {
//                print("Error decoding user data: \(error.localizedDescription)")
//            }
////        }
//        return nil
//    }
