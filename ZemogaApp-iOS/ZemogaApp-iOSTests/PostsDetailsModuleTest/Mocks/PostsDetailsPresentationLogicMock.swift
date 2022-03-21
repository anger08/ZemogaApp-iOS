//
//  PostsDetailsPresentationLogicMock.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 20/3/22.
//

import Foundation
@testable import ZemogaApp_iOS

final class PostsDetailsPresentationLogicMock: PostsDetailsPresentationLogic {
    
    var responseUsers: PostsDetailsModel.Users.Response?
    var responseComments: PostsDetailsModel.Comments.Response?
    var isFunctionWasCalled = false
    
    func presentUsers(response: [PostsDetailsModel.Users.Response]) {
        if responseUsers != nil {
            isFunctionWasCalled = true
        }
    }
    
    func presentComments(response: [PostsDetailsModel.Comments.Response]) {
        if responseComments != nil {
            isFunctionWasCalled = true
        }
    }
    
    func presentError(response: PostsHomeModel.Error.Response) {
        isFunctionWasCalled = true
    }
}
