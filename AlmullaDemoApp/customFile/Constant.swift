//
//  Constant.swift
//  AlmullaDemoApp
//
//  Created by Ashwini Apurkar on 09/10/20.
//  Copyright © 2020 Ashwini Apurkar. All rights reserved.
//

import UIKit

class Constant: NSObject {
    
    static var selectedLanguageCode : String = "en"

}


extension String {
    func localized() ->String {
        
        let path = Bundle.main.path(forResource: Constant.selectedLanguageCode, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
}
