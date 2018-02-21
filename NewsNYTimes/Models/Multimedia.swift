//
//  Multimedia.swift
//  BMuseTestTask
//
//  Created by Anastasia on 2/5/18.
//  Copyright © 2018 Anastasia. All rights reserved.
//

import UIKit

class Multimedia {
    var url = ""
    var format = ""
    
    init(dict: Dictionary<String, Any>) {
        guard let url =  dict["url"] as? String else { return }
        self.url = url
        
        guard let format = dict["format"] as? String else  { return }
        self.format = format
    }
    
    init() {
        url = ""
        format = ""
    }
}
