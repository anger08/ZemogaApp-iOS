//
//  PostsDetailsWorkerMock.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 20/3/22.
//

import Foundation
@testable import ZemogaApp_iOS

class PostsDetailsWorkerMock : PostsDetailsServiceProtocol {
    
    var resultGetUsers: (Result<[PostsDetailsModel.Users.Response], PostsHomeError>)?
    var resultGetComments: (Result<[PostsDetailsModel.Comments.Response], PostsHomeError>)?
    var isFunctionWasCalled = false

    func getUsers(request: PostsDetailsModel.Users.Request, completion: @escaping (Result<[PostsDetailsModel.Users.Response], PostsHomeError>) -> Void) {
        if let result = resultGetUsers {
            isFunctionWasCalled = true
            completion(result)
        }
    }
    
    func getComments(request: PostsDetailsModel.Comments.Request, completion: @escaping (Result<[PostsDetailsModel.Comments.Response], PostsHomeError>) -> Void) {
        if let result = resultGetComments {
            isFunctionWasCalled = true
            completion(result)
        }
    }
}
