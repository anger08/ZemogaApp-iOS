//
//  PostsHomePresentationLogicMock.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 20/3/22.
//

import Foundation
@testable import ZemogaApp_iOS

final class PostsHomePresentationLogicMock: PostsHomePresentationLogic {
    
    var responsePostsHome: PostsHomeModel.Posts.Response?
    var isFunctionWasCalled = false
    
    func presentPosts(response: [PostsHomeModel.Posts.Response]) {
        if responsePostsHome != nil {
            isFunctionWasCalled = true
        }
    }
    
    func presentError(response: PostsHomeModel.Error.Response) {
        isFunctionWasCalled = true
    }
}
