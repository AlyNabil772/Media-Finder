//
//  UserModel.swift
//  mediafinder
//
//  Created by ALY NABIL on 10/05/2024.
//

import Foundation
import UIKit

enum Gender: String, Codable {
    case male = "Male"
    case femail = "Female"
}

struct User: Codable {
    
    var name: String
    var email: String
    var password: String
    var phone: String
    var address: String
    var userImage: Data
    var gender : Gender
}
