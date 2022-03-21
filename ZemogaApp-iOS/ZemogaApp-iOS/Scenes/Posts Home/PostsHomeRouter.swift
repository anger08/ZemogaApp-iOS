//
//  PostsHomeRouter.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import Foundation

@objc protocol PostsHomeRoutingLogic {
}

protocol PostsHomeDataPassing {
    var dataStore: PostsHomeDataStore? { get }
}

class PostsHomeRouter: NSObject, PostsHomeRoutingLogic, PostsHomeDataPassing {
    weak var viewController: PostsHomeViewController?
    var dataStore: PostsHomeDataStore?
  
}
