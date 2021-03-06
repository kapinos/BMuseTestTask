//
//  ArticleTableViewCell.swift
//  BMuseTestTask
//
//  Created by Anastasia on 2/5/18.
//  Copyright © 2018 Anastasia. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    // MARK:  - IBOutlets
    @IBOutlet weak var articlePhoto: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articlePublishedDateLabel: UILabel!
    
    func configureCell(article: Article) {
        articleTitleLabel.text = article.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: article.data) else { return }
        articlePublishedDateLabel.text = "\(date)"
        
        if !article.multimediaStandart.url.isEmpty {
            downloadImageByUrl(article.multimediaStandart.url)
        }
    }
}

private extension ArticleTableViewCell {
    func downloadImageByUrl(_ standartFormatUrl: String) {
        guard let url = URL(string: standartFormatUrl) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async(execute: { [weak self] () -> Void in
                guard let data = data else { return }
                self?.articlePhoto.image = UIImage(data: data)
            })
        }).resume()
    }
}
