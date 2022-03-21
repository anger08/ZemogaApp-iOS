//
//  PostsDetailsInteractor.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import Foundation
import UIKit

protocol PostsDetailsBusinessLogic {
    func getUsers(request: PostsDetailsModel.Users.Request)
    func getComments(request: PostsDetailsModel.Comments.Request)
}

protocol PostsDetailsDataStore {
}

class PostsDetailsInteractor: PostsDetailsBusinessLogic, PostsDetailsDataStore {
    
    var presenter: PostsDetailsPresentationLogic?
    var worker: PostsDetailsServiceProtocol
    
    init(worker: PostsDetailsServiceProtocol = PostsDetailsAPI()) {
        self.worker = worker
    }
    
    // MARK: - Methods
    func getUsers(request: PostsDetailsModel.Users.Request) {
        worker.getUsers(request: request, completion: { result in
            switch result {
            case .success(let response):
                self.presenter?.presentUsers(response: response)
            case .failure(let error):
                let response = PostsHomeModel.Error.Response(error: error)
                self.presenter?.presentError(response: response)
            }
        })
    }
    
    func getComments(request: PostsDetailsModel.Comments.Request) {
        worker.getComments(request: request, completion: { result in
            switch result {
            case .success(let response):
                self.presenter?.presentComments(response: response)
            case .failure(let error):
                let response = PostsHomeModel.Error.Response(error: error)
                self.presenter?.presentError(response: response)
            }
        })
    }

}
