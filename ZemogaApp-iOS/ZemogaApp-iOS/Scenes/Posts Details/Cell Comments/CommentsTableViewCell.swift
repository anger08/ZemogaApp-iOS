//
//  CommentsTableViewCell.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var commentsLabel: UILabel!
    
    static let reuseIdentifier = "commentsViewCell"
    static let cellHeight: CGFloat = 80

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configUI(comments: PostsDetailsModel.Comments.Response){
        commentsLabel.text   = comments.body
    }
    
}
