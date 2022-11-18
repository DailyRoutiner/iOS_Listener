//
//  SearchTableViewCell.swift
//  Listener
//
//  Created by Dongpeng Dai on 2022/7/28.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configData(data: Book) {
        bookName.text = data.name
        bookDescription.text = data.detail
        bookAuthor.text = data.author
        bookImage.image = UIImage(named: data.image!)
    }

}
