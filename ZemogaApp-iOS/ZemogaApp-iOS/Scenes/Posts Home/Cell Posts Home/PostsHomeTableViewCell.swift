//
//  PostsHomeTableViewCell.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import UIKit

class PostsHomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    static let reuseIdentifier = "postsViewCell"
    static let cellHeight: CGFloat = 64
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configUI(posts: PostsHomeModel.Posts.Response, state: Bool) {
        circleImageView.isHidden = false
        descriptionTextLabel.text = posts.title
        if posts.isFavorite {
            circleImageView.isHidden = false
            circleImageView.image = UIImage(named: "favoriteFilled")
        } else {
            if posts.isSelected {
                circleImageView.isHidden = true
                circleImageView.image = UIImage(named: "circle")
            } else {
                circleImageView.isHidden = false
                circleImageView.image = UIImage(named: "circle")
            }
        }
    }
    
}
