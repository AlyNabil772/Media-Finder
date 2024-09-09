//
//  SQLiteManager.swift
//  mediafinder
//
//  Created by ALY NABIL on 06/06/2024.
//
import UIKit
import SQLite

class SqlManager {
    
    static let shared = SqlManager()
    private init() {}
    
    //MARK: - Properties
    var database: Connection!
    let userTable = Table("users")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    let password = Expression<String>("password")
    let phone = Expression<String>("phone")
    let address = Expression<String>("address")
    let image = Expression<Data>("image")
    let gender = Expression<String>("gender")
    
    
    //   //MARK: - Methods
    // should call this func in APPDelegate
    func setupDatabase() {
        do {
            let documentsDirectory  = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentsDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileURL.path)
            self.database = database
        }catch {
            print(error.localizedDescription)
        }
    }
    // should call this func in SignUpVC in ViewDidLoad
    func createTable() {
        let createTable = self.userTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.name)
            table.column(self.email)
            table.column(self.password)
            table.column(self.phone)
            table.column(self.address)
            table.column(self.image)
            table.column(self.gender)
            print("createTable")
            
        }
        do {
            try self.database.run(createTable)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func insertData(userData: User) {
        do {
            let insert = userTable.insert(self.name <- userData.name, self.email <- userData.email, self.password <- userData.password, self.phone <- userData.phone, self.address <- userData.address, self.image <- userData.userImage, self.gender <- userData.gender.rawValue)
            print("insertData")
            try self.database.run(insert)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchData(email: String) -> User? {
        do {
            let users = try self.database.prepare(self.userTable)
            for user in users {
                let userData = User( id: user[self.id], name: user[self.name], email: user[self.email], password: user[self.password], phone: user[self.phone], address: user[self.address], userImage: user[self.image], gender: Gender(rawValue: user[self.gender]) ?? .male)
                if email == userData.email {
                    print("fetchData")
                    return userData
                }
            }
        }catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

