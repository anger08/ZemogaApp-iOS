//
//  PostsHomeWorkerMock.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 20/3/22.
//

import Foundation
@testable import ZemogaApp_iOS

class PostsHomeWorkerMock : PostsServiceProtocol {
    
    var resultGetPosts: (Result<[PostsHomeModel.Posts.Response], PostsHomeError>)?
    var isFunctionWasCalled = false
    
    func getPosts(request: PostsHomeModel.Posts.Request, completion: @escaping (Result<[PostsHomeModel.Posts.Response], PostsHomeError>) -> Void) {
        if let result = resultGetPosts {
            isFunctionWasCalled = true
            completion(result)
        }
    }
}
