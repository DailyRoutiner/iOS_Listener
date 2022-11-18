//
//  BookDetailViewController.swift
//  finalProject
//
//  Created by Seongjun Choi on 2022/07/28.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    var bookDetail: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        self.bookImage.image = UIImage(named: bookDetail.image!)
        self.title = bookDetail.name
        self.authorLabel.text = bookDetail.author
        self.detailLabel.text = bookDetail.detail
        self.likeBtn.backgroundColor = bookDetail.isLiked ? .systemPink : .gray
    }
    
    @IBAction func likedClick(_ sender: UIButton) {
        if bookDetail.isLiked {
            bookDetail.isLiked = false
            likeBtn.backgroundColor = .gray
        }else{
            bookDetail.isLiked = true
            likeBtn.backgroundColor = .systemPink
        }
        
        BookProvider().saveBook(book: bookDetail)
    }
    
    @IBAction func playBook(_ sender: UIButton) {
        let vc = MainNavigationViewController.getPlayerController(book: self.bookDetail)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func configData(with book: Book){
        self.bookDetail = book
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
