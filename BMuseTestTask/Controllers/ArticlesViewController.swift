//
//  ArticlesViewController.swift
//  BMuseTestTask
//
//  Created by Anastasia on 2/5/18.
//  Copyright © 2018 Anastasia. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {
    
    // MARK: -IBOutlets
    @IBOutlet weak var categoriesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var articlesTableView: UITableView!
    
    // MARK: - Properties
    private var token: NSKeyValueObservation?
    //private let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        //formatter.dateFormat = "MMM d, h:mm a"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        token = NewsAPI.service.observe(\NewsAPI.artArray) { _, _ in
            DispatchQueue.main.async {
                self.articlesTableView.reloadData()
                //print(NewsAPI.service.artArray)
            }
        }
        NewsAPI.service.fetchArt()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        token?.invalidate()
        NewsAPI.service.resetArticles()
    }
}


// MARK: -UITableViewDataSource

extension ArticlesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsAPI.service.artArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        cell.configureCell(article: NewsAPI.service.artArray[indexPath.row])
        return cell
    }
}


// MARK: -UITableVIewDelegate

extension ArticlesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
