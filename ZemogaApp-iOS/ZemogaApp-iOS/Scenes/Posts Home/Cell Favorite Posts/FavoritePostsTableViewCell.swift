//
//  FavoritePostsTableViewCell.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 19/3/22.
//

import UIKit

class FavoritePostsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var circleFavoriteImageView: UIImageView!
    @IBOutlet weak var messageFavoriteLabel: UILabel!
    @IBOutlet weak var nextFavoriteButton: UIButton!
    
    static let reuseIdentifier = "favoritePostsViewCell"
    static let cellHeight: CGFloat = 64

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configUI(posts: PostsHomeModel.Posts.Response, state: Bool, favorite: Bool) {
        messageFavoriteLabel.text = posts.title
    }
    
}
