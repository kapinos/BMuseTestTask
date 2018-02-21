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
    private var _byline: String!
    private var _data: String!
    private var _url: String!
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
    
    var byline: String {
        if _byline == nil {
            _byline = ""
        }
        return _byline
    }
    
    var data: String {
        if _data == nil {
            _data = ""
        }
        return _data
    }
    
    var url: String {
        if _url == nil {
            _url = ""
        }
        return _url
    }
    
    var multimediaStandart: Multimedia {
        if _multimediaStandart == nil {
            _multimediaStandart = Multimedia()
        }
        return _multimediaStandart
    }
    
    var multimediaThreeByTwo: Multimedia {
        if _multimediaThreeByTwo == nil {
            _multimediaThreeByTwo = Multimedia()
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
        
        if let byline = dict["byline"] as? String {
            self._byline = byline
        }
        
        if let url = dict["url"] as? String {
            self._url = url
        }

        guard let multimediaArray = dict["multimedia"] as? [Dictionary<String, Any>] else { return }
        if multimediaArray.isEmpty { return }
        
        for multimediaData in multimediaArray {
            let multimedia = Multimedia(dict: multimediaData)
            
            if multimedia.format == "Standard Thumbnail" {
                self._multimediaStandart = multimedia
            } else if multimedia.format == "mediumThreeByTwo210" {
                self._multimediaThreeByTwo = multimedia
            }
        }
    }
}
