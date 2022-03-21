//
//  PostsDetailsRouter.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import Foundation

@objc protocol PostsDetailsRoutingLogic {
}

protocol PostsDetailsDataPassing {
    var dataStore: PostsDetailsDataStore? { get }
}

class PostsDetailsRouter: NSObject, PostsDetailsRoutingLogic, PostsDetailsDataPassing {
    weak var viewController: PostsDetailsViewController?
    var dataStore: PostsDetailsDataStore?
}
