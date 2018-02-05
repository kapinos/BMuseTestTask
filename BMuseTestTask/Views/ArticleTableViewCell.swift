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
        //articlePhoto.image =
        articleTitleLabel.text = article.title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: article.data) else { return }
        articlePublishedDateLabel.text = "\(date)"
    }
}
