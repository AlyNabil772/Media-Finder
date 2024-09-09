//
//  APIManager.swift
//  mediafinder
//
//  Created by ALY NABIL on 19/06/2024.
//

import Alamofire
import Foundation

class APIManager {
    
    static func getMediaData(term: String, media: String, completion: @escaping (_ error: Error?, _ mediaArry:[Result]?) -> Void) {
        let param = [ParameterKeys.term: term, ParameterKeys.media: media]
        
        AF.request(URLs.baseURL, method: .get, parameters: param, encoding: URLEncoding.default, headers: nil).response { response in
            
            guard response.error == nil else {
                print("Error: \(response.error?.localizedDescription)")
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("Error: \(response.error?.localizedDescription)")
                completion(response.error, nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let mediaArry = try decoder.decode(MediaResponse.self, from: data).results
                completion(nil, mediaArry)

            } catch {
                print("Error: \(error.localizedDescription)")

            }
        }
    }
}

