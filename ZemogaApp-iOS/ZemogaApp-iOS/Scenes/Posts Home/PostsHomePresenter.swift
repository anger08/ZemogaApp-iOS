//
//  PostsHomePresenter.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import Foundation

protocol PostsHomePresentationLogic {
    func presentPosts(response: [PostsHomeModel.Posts.Response])
    func presentError(response: PostsHomeModel.Error.Response)
}

class PostsHomePresenter: PostsHomePresentationLogic {
    
    weak var viewController: PostsHomeDisplayLogic?
    
    // MARK: - Present Posts
    func presentPosts(response: [PostsHomeModel.Posts.Response]) {
        let viewModel = PostsHomeModel.Posts.ViewModel(data: response)
        viewController?.displayPosts(viewModel: viewModel, on: .main)
    }
    
    // MARK: - Present Error
    func presentError(response: PostsHomeModel.Error.Response) {
        let viewModel = PostsHomeModel.Error.ViewModel(error: response.error)
        viewController?.displayError(viewModel: viewModel, on: .main)
    }
}
