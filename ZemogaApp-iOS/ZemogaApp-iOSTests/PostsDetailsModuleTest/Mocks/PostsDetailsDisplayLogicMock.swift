//
//  PostsDetailsDisplayLogicMock.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 20/3/22.
//

import Foundation
@testable import ZemogaApp_iOS

final class PostsDetailsDisplayLogicMock: PostsDetailsDisplayLogic {
    
    var viewModelDisplayUsers: PostsDetailsModel.Users.ViewModel?
    var viewModelDisplayComments: PostsDetailsModel.Comments.ViewModel?
    var isFunctionWasCalled = false
    
    func displayUsers(viewModel: PostsDetailsModel.Users.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
    
    func displayComments(viewModel: PostsDetailsModel.Comments.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
    
    func displayError(viewModel: PostsHomeModel.Error.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
}
