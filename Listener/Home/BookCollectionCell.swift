//
//  BookCollectionCell.swift
//  Listener
//
//  Created by Seongjun Choi on 2022/08/04.
//

import UIKit

class BookCollectionCell: UICollectionViewCell {

    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with book: Book){
        self.bookImage.image = UIImage(named: book.image!)
        self.bookTitle.text = book.name
        self.author.text = book.author
    }
}
