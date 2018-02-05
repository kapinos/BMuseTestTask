//
//  Multimedia.swift
//  BMuseTestTask
//
//  Created by Anastasia on 2/5/18.
//  Copyright © 2018 Anastasia. All rights reserved.
//

import UIKit

class Multimedia {
    var url  = ""
    var format = ""
    
    init(dict: Dictionary<String, Any>) {
        if let url = dict["url"] as? String {
            self.url = url
        }
        
        if let format = dict["format"] as? String {
            self.format = format
        }
    }
}
