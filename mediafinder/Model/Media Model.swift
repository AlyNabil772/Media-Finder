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

//extension MediaModel {
//    static func generateData() -> [MediaModel] {
//        var data: [MediaModel] = []
//        data.append(MediaModel(name: "Avatar", year: "2009", image: "https://images.moviesanywhere.com/7fbdd5c310d10623af2d040a726c4447/850a4464-275c-458f-a26a-fa6fdd4ab18c.jpg"))
//        data.append(MediaModel(name: "Troy", year: "2004", image: "https://alexsreviewcorner.com/wp-content/uploads/2022/06/troy.jpg?w=800"))
//        data.append(MediaModel(name: "Titanic", year: "1997", image: "https://m.media-amazon.com/images/I/81CVRAQi46L._AC_UF894,1000_QL80_.jpg"))
//        data.append(MediaModel(name: "Cast a Way", year: "2000", image: "https://i.pinimg.com/originals/65/34/36/65343634bafdcc7f2bfe9d92c554f425.jpg"))
//        return data
//    }
//}

enum MediaType: String {
    case all = "all"
    case tvShow = "tvShow"
    case music = "music"
    case movie = "movie"
}
 
// MARK: - MediaResponse
struct MediaResponse: Codable {
    let resultCount: Int?
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let artistName, trackName: String?
    let previewUrl: String?
    let artworkUrl: String?
    let releaseDate: String?
    let longDescription: String?

    enum CodingKeys: String, CodingKey {
        case artistName
        case trackName
        case previewUrl
        case releaseDate
        case artworkUrl = "artworkUrl100"
        case longDescription
   
    }
}




