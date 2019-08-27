//
//  Character.swift
//  Simpsons Character Viewer
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import Foundation

class Character {
    private var _name: String?
    private var _description: String?
    private var _imageURL: String?
    
    private enum Keys: String {
        case Name = "Text"
        case Icon = "Icon"
        case ImageUrl = "URL"
    }
    
    init(dict: [String: Any]) {
        if let description = dict[Keys.Name.rawValue] as? String {
            let stringArray = description.components(separatedBy: " - ")
            _name = stringArray[0]
            _description = stringArray[1]
        }
        
        if let icon = dict[Keys.Icon.rawValue] as? [String: Any], let url = icon[Keys.ImageUrl.rawValue] as? String {
            _imageURL = url
        }
    }
    
    var name: String {
        if let name = _name {
            return name
        }
        return ""
    }
    
    var description: String {
        if let description = _description {
            return description
        }
        return ""
    }
    
    var imageUrl: String {
        if let url = _imageURL {
            return url
        }
        return ""
    }
}
