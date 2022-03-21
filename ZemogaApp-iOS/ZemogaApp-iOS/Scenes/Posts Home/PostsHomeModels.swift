//
//  PostsHomeModels.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import Foundation

enum PostsHomeModel {
    // MARK: Use cases
    enum Posts {
        struct Request {
        }
        
        struct Response: Codable {
            // MARK: - DataClass
            struct DataClass: Codable {
            }
            
            let userId      : Int?
            let id          : Int?
            let title       : String?
            let body        : String?
            var isSelected  = false
            var isFavorite  = false
            
            enum CodingKeys: String, CodingKey {
                case userId
                case id
                case title
                case body
            }
        }
        
        struct ViewModel {
            let data: [PostsHomeModel.Posts.Response]
            
        }
    }
    
    enum Error {
        struct Request {
        }
        struct Response {
            var error: PostsHomeError
        }
        struct ViewModel {
            var error: PostsHomeError
        }
    }
}
