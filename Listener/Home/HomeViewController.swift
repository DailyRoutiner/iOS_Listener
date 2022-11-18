//
//  HomeViewController.swift
//  Listener
//  Seongjun Choi
//

import UIKit

class HomeViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl?.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let content = cell.contentView.subviews.first as! HomeContentView
        if !self.children.contains(content.internalController) {
            self.addChild(content.internalController)
        }
        return cell
    }
    
    @objc
    func refresh(_ sender: UIRefreshControl) {
        APIManager().getAllBooks { books in
            DispatchQueue.main.async {
                print("receive books " + books.description)
                sender.endRefreshing()
            }
        }
    }
}
