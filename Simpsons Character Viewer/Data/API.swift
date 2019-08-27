//
//  API.swift
//  Simpsons Character Viewer
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import Foundation
import Alamofire

enum APIError: Error {
    case invalidURL
    case invalidJSONData
    case requestUnavailable
}

enum GetResult {
    case success(Any)
    case failure(Error)
}

class API {
    let configurationManager = ConfigurationManager.instance
    
    func getCharacters(urlKey: URLKey, completed: @escaping (GetResult) -> ()) {
        let url = getURL(urlKey: urlKey)
        print(url)
        Alamofire.request(url).responseJSON { (response) in
            guard response.result.error == nil else {
                return completed(.failure(response.result.error!))
            }
            
            guard let object = response.result.value as? [String: Any] else {
                return completed(.failure(APIError.invalidJSONData))
            }
            
            guard let data = object["RelatedTopics"] as? [[String: Any]] else {
                return completed(.failure(APIError.invalidJSONData))
            }
            
            var charArray = [Character]()

            for i in data {
                let chara = Character(dict: i)
                charArray.append(chara)
            }
            
            return completed(.success(charArray))
        }
    }
    
    func getURL(urlKey: URLKey) -> URL {
        let urlString = configurationManager.urlForPath(urlKey: urlKey)
        return URL(string: urlString)!
    }
}
