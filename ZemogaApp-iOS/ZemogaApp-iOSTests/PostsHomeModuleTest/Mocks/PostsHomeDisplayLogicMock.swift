//
//  PostsHomeDisplayLogicMock.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 20/3/22.
//

import Foundation
@testable import ZemogaApp_iOS

final class PostsHomeDisplayLogicMock: PostsHomeDisplayLogic {
    
    var viewModelDisplayPostsHome: PostsHomeModel.Posts.ViewModel?
    var isFunctionWasCalled = false
    
    func displayPosts(viewModel: PostsHomeModel.Posts.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
    
    func displayError(viewModel: PostsHomeModel.Error.ViewModel, on queu: DispatchQueue) {
        isFunctionWasCalled = true
    }
}
