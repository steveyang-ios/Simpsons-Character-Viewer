//
//  String+Extensions.swift
//  Simpsons Character Viewer
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import Foundation

extension String {
    var stringToNSString: NSString {
        return NSString(string: self)
    }
}
