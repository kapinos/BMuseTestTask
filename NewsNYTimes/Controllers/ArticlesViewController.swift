//
//  ArticlesViewController.swift
//  BMuseTestTask
//
//  Created by Anastasia on 2/5/18.
//  Copyright © 2018 Anastasia. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var articlesTableView: UITableView!
    
    // MARK: - Properties
    private var token: NSKeyValueObservation?
    private var customMenu = MenuView()
    private var selectedCategory = "world"

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpMenu()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadAndShowArticles(by: selectedCategory)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        token?.invalidate()
        NewsAPI.service.resetArticles()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) in
            self.setUpMenu()
            
            let navBarHeight: CGFloat = self.navigationController?.navigationBar.frame.size.height ?? 0
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            self.customMenu.updateFrames(size, navBarHeight, statusBarHeight)
        }, completion: nil)
    }
}

// MARK: - Navigation
extension ArticlesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ArticleDetailsSegue" {
            guard let detailsVC = segue.destination as? ArticleDetailsViewController else { return }
            guard let article = sender as? Article else  { return }
            detailsVC.article = article
        }
    }
}

// MARK: - Download Articles by Section
private extension ArticlesViewController {
    func downloadAndShowArticles(by section: String) {
        token = NewsAPI.service.observe(\NewsAPI.articles) { _, _ in
            DispatchQueue.main.async {
                self.articlesTableView.reloadData()
            }
        }
        NewsAPI.service.fetchArticles(by: section)
    }
}

// MARK: - User Actions
extension ArticlesViewController {
    @IBAction func menuPressed(_ sender: UIBarButtonItem) {
        if customMenu.isHidden {
            customMenu.show()
        } else {
            customMenu.hide()
        }
    }
}

// MARK: - UITableViewDataSource
extension ArticlesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsAPI.service.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleTableViewCell {
            cell.articlePhoto.image = UIImage(named: "no-photo.png")
            cell.configureCell(article: NewsAPI.service.articles[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UITableVIewDelegate
extension ArticlesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = NewsAPI.service.articles[indexPath.row]
        performSegue(withIdentifier: "ArticleDetailsSegue", sender: article)
        customMenu.hide(isAnimated: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        customMenu.hide(isAnimated: false)
    }
}

// MARK: - MenuViewDelegate
extension ArticlesViewController: MenuViewDelegate {
    func menuView(didSelectItem item: String) {        
        downloadAndShowArticles(by: item)
        selectedCategory = item
        self.title = String(describing: item.first!).uppercased() + item.dropFirst()
        customMenu.isHidden = true
    }
}

// MARK: - Menu
private extension ArticlesViewController {
    func setUpMenu() {
        
        let navBarHeight: CGFloat = self.navigationController?.navigationBar.frame.size.height ?? 0
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let heightMenu = self.view.bounds.height - navBarHeight - statusBarHeight
        
        customMenu.frame = CGRect(origin: CGPoint(x: 0, y: (navBarHeight + statusBarHeight)),
                                   size: CGSize(width: heightMenu/CGFloat(customMenu.amountButtons), height: heightMenu))
        customMenu.backgroundColor = .clear
        customMenu.delegate = self
        customMenu.imagesNames = setNames()
        customMenu.isHidden = true
        
        let window = UIApplication.shared.keyWindow!
        window.addSubview(customMenu)
    }
    
    func setNames() -> [String] {
        var names: [String] = []
        names.append("world.png")
        names.append("business.png")
        names.append("politics.png")
        names.append("science.png")
        names.append("sports.png")
        names.append("movies.png")
        names.append("food.png")
        return names
    }
}

