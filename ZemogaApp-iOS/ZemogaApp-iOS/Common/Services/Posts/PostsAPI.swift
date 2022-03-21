//
//  PostsAPI.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import Foundation

// MARK: - PostsServiceProtocol
protocol PostsServiceProtocol {
    func getPosts(request: PostsHomeModel.Posts.Request, completion: @escaping (Result<[PostsHomeModel.Posts.Response], PostsHomeError>) -> Void)
}

// MARK: - PostsAPI
class PostsAPI: PostsServiceProtocol {
// Comunication with EndPoint
    func getPosts(request: PostsHomeModel.Posts.Request, completion: @escaping (Result<[PostsHomeModel.Posts.Response], PostsHomeError>) -> Void) {
        NetworkService.share.request(endpoint: PostsHomeEndpoint.getPosts) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode([PostsHomeModel.Posts.Response].self, from: data!)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(.network(error)))
            }
        }
    }
}
