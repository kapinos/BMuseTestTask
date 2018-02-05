//
//  NewsApi.swift
//  BMuseTestTask
//
//  Created by Anastasia on 2/5/18.
//  Copyright © 2018 Anastasia. All rights reserved.
//

import Foundation

class NewsAPI: NSObject {
    
    static let service = NewsAPI()

    private static let basePath = "http://api.nytimes.com/svc/topstories/v2"
    private static let key = "28cb01bb663c4efe9e5f18259c02f998"
    
    // FIXME: - create methods for get/set category
    static var category = "home"
    
    private func path() -> URL {
        return URL(string: "\(NewsAPI.basePath)/\(NewsAPI.category).json?api-key=\(NewsAPI.key)")!
    }

    @objc dynamic private(set) var articles: [Article] = []

    func resetArticles() {
        articles = []
    }
    
    func fetchArticles() {
        let url = path()
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let str = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                //print(str)
                if let dict = str as? Dictionary<String, Any> {
                    if let list = dict["results"] as? [Dictionary<String, Any>] {
                        //self.artArray.removeAll()
                        var articlesFromData: [Article] = []
                        for object in list {
                            let article = Article(dict: object)
                            articlesFromData.append(article)
                        }
                        self.articles = articlesFromData
                    }
                }
            } catch {
                print("json error: \(error)")
            }
        })
        task.resume()
    }
}


