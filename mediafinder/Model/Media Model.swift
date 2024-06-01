//
//  Media Model.swift
//  mediafinder
//
//  Created by ALY NABIL on 31/05/2024.
//

import Foundation

struct MediaModel: Codable {
    var name: String
    var year: String
    var image: String
}

extension MediaModel {
    static func generateData() -> [MediaModel] {
        var data: [MediaModel] = []
        data.append(MediaModel(name: "Avatar", year: "2009", image: "1"))
        data.append(MediaModel(name: "Troy", year: "2004", image: "2"))
        data.append(MediaModel(name: "Titanic", year: "1997", image: "3"))
        data.append(MediaModel(name: "Cast a Way", year: "2000", image: "4"))
        return data
    }
}
