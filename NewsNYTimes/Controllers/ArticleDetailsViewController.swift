//
//  ArticleDetailsViewController.swift
//  BMuseTestTask
//
//  Created by Anastasia on 2/5/18.
//  Copyright © 2018 Anastasia. All rights reserved.
//

import UIKit

class ArticleDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTextView: UITextView!
    @IBOutlet weak var articleAuthor: UILabel!

    // MARK: - Properties
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleTitleLabel.numberOfLines = 0
        articleTextView.sizeToFit()
        articleTextView.isScrollEnabled = false
        
        showArticle()
    }
}

// MARK: - User Actions
extension ArticleDetailsViewController {
    @IBAction func buttonOpenTapped(_ sender: UIButton) {
        guard let urlString = article?.url,
            let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:])
    }
}

// MARK: - Set Up Methods
private extension ArticleDetailsViewController {
    func showArticle() {
        guard let art = article else { return }
        
        articleTitleLabel.text = art.title
        articleTextView.text = art.abstract
        articleAuthor.text = art.byline
        
        if !art.multimediaThreeByTwo.url.isEmpty {
            downloadImageByUrl(art.multimediaThreeByTwo.url)
        }
    }
    
    private func downloadImageByUrl(_ standartFormatUrl: String) {
        guard let url = URL(string: standartFormatUrl) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async(execute: { [weak self] () -> Void in
                guard let data = data else { return }
                self?.articleImageView.image = UIImage(data: data)
            })
        }).resume()
    }
}
