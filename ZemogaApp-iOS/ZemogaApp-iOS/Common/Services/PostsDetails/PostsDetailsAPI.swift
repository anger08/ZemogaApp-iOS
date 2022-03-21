//
//  PostsDetailsAPI.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import Foundation

// MARK: - PostsDetailsServiceProtocol
protocol PostsDetailsServiceProtocol {
    func getUsers(request: PostsDetailsModel.Users.Request, completion: @escaping (Result<[PostsDetailsModel.Users.Response], PostsHomeError>) -> Void)
    func getComments(request: PostsDetailsModel.Comments.Request, completion: @escaping (Result<[PostsDetailsModel.Comments.Response], PostsHomeError>) -> Void)
}

// MARK: - PostsDetailsAPI
class PostsDetailsAPI: PostsDetailsServiceProtocol {
    // Comunication with EndPoint
    func getUsers(request: PostsDetailsModel.Users.Request, completion: @escaping (Result<[PostsDetailsModel.Users.Response], PostsHomeError>) -> Void) {
        NetworkService.share.request(endpoint: PostsDetailsEndpoint.getUsers) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode([PostsDetailsModel.Users.Response].self, from: data!)
                    completion(.success(response))
                } catch let error {
                    completion(.failure(.parse(error)))
                }
            case .failure(let error):
                completion(.failure(.network(error)))
            }
        }
    }
    // Comunication with EndPoint
    func getComments(request: PostsDetailsModel.Comments.Request, completion: @escaping (Result<[PostsDetailsModel.Comments.Response], PostsHomeError>) -> Void) {
        NetworkService.share.request(endpoint: PostsDetailsEndpoint.getComments) { result in
            switch result {
            case .success:
                do {
                    let data = try result.get()
                    let response = try JSONDecoder().decode([PostsDetailsModel.Comments.Response].self, from: data!)
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
