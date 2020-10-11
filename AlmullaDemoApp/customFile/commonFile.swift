//
//  commonFile.swift
//  AlmullaDemoApp
//
//  Created by Ashwini Apurkar on 06/10/20.
//  Copyright © 2020 Ashwini Apurkar. All rights reserved.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return self.substring(from: index(self.startIndex, offsetBy: from))
    }
    
    var length: Int {
        return self.count
    }
}
