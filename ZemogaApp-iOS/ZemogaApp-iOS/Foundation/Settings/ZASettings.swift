//
//  ZASettings.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import Foundation
import UIKit

struct ZASettings {
    
    static var current: ZASettings = .init()
    
    let defaults = UserDefaults.standard
    var postSelected : [PostsHomeModel.Posts.Response]? = []
    var postFavorite : [PostsHomeModel.Posts.Response]? = []
}
