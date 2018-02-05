//
//  Article.swift
//  BMuseTestTask
//
//  Created by Anastasia on 2/5/18.
//  Copyright © 2018 Anastasia. All rights reserved.
//

import Foundation

class Article: NSObject {
    
    private var _title: String!
    private var _abstract: String!
    private var _data: String!
    private var _multimediaStandart: Multimedia!
    private var _multimediaThreeByTwo: Multimedia!
    
    var title: String {
        if _title == nil {
            _title = ""
        }
        return _title
    }

    var abstract: String {
        if _abstract == nil {
            _abstract = ""
        }
        return _abstract
    }
    
    var data: String {
        if _data == nil {
            _data = ""
        }
        return _data
    }
    
    var multimediaStandart: Multimedia {
        if _multimediaStandart == nil {
            _multimediaStandart.url = ""
            _multimediaStandart.format = ""
        }
        return _multimediaStandart
    }
    
    var multimediaThreeByTwo: Multimedia {
        if _multimediaThreeByTwo == nil {
            _multimediaThreeByTwo.url = ""
            _multimediaThreeByTwo.format = ""
        }
        return _multimediaThreeByTwo
    }
    
 
    init(dict: Dictionary<String, Any>) {
        
        if let title = dict["title"] as? String {
            self._title = title
        }
        
        if let abstract = dict["abstract"] as? String {
            self._abstract = abstract
        }
        
        if let data = dict["published_date"] as? String {
            self._data = data
        }

//        if let multimedia = dict["multimedia"] as? [Dictionary<String, Any>] {
//            if let multimediaStandart = dict[""]
//        }
        
    }
}
