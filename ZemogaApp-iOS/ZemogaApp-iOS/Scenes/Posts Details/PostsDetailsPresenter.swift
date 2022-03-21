//
//  PostsDetailsPresenter.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import Foundation
import UIKit

protocol PostsDetailsPresentationLogic {
    func presentUsers(response: [PostsDetailsModel.Users.Response])
    func presentComments(response: [PostsDetailsModel.Comments.Response])
    func presentError(response: PostsHomeModel.Error.Response)
}

class PostsDetailsPresenter: PostsDetailsPresentationLogic {
    
    weak var viewController: PostsDetailsDisplayLogic?
    
    // MARK: - Present Users
    func presentUsers(response: [PostsDetailsModel.Users.Response]) {
        let viewModel = PostsDetailsModel.Users.ViewModel(data: response)
        viewController?.displayUsers(viewModel: viewModel, on: .main)
    }
    
    // MARK: - Present Users
    func presentComments(response: [PostsDetailsModel.Comments.Response]) {
        let viewModel = PostsDetailsModel.Comments.ViewModel(data: response)
        viewController?.displayComments(viewModel: viewModel, on: .main)
    }
    
    // MARK: - Present Error
    func presentError(response: PostsHomeModel.Error.Response) {
        let viewModel = PostsHomeModel.Error.ViewModel(error: response.error)
        viewController?.displayError(viewModel: viewModel, on: .main)
    }
}
