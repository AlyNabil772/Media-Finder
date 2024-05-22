//
//  ValidationManager.swift
//  mediafinder
//
//  Created by ALY NABIL on 21/05/2024.
//

import Foundation

class ValidationManager {
    
    //MARK: - Singleton
    private static let sharedInstance = ValidationManager()
    static func shared() -> ValidationManager {
        return sharedInstance
    }
//    static let shared = ValidationManager() // i can use this code instead of previous code
    private init() {}
    
    
    private let format: String = "SELF MATCHES %@" // this code to reduce the hard coded
    
    func validationOn(email: String) -> Bool { // this func to make regex for email
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" // regex code
        let predicate = NSPredicate(format: format, regex) // make prediction according email
        return predicate.evaluate(with: email) // make evaluation for email
    }
    func validationOn(password: String) -> Bool { // this func to make regex for password
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$" // regex code
        let predicate = NSPredicate(format: format, regex) // make prediction according password
        return predicate.evaluate(with: password) // make evaluation for password
    }
    func validationOn(phone: String) -> Bool { // / this func to make regex for phone
        let regex = "^[0-9]{11}$" // regex code
        let predicate = NSPredicate(format: format, regex) // make prediction according phone
        return predicate.evaluate(with: phone) //  make evaluation for phone
    }
}
