//
//  PostsDetailsModels.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import Foundation

enum PostsDetailsModel {
    // MARK: - Use cases
    enum Users {
        struct Request {
        }
        
        struct Response: Codable {
            // MARK: - DataClass
            struct DataClass: Codable {
            }
            
            let id      : Int?
            let name    : String?
            let email   : String?
            let phone   : String?
            let website : String?
            
            enum CodingKeys: String, CodingKey {
                case id
                case name
                case email
                case phone
                case website
            }
        }
        
        struct ViewModel {
            let data: [PostsDetailsModel.Users.Response]
        }
    }
    
    // MARK: - Use cases
    enum Comments {
        struct Request {
        }
        
        struct Response: Codable {
            // MARK: - DataClass
            struct DataClass: Codable {
            }
            
            let postId  : Int?
            let id      : Int?
            let name    : String?
            let email   : String?
            let body    : String?
            
            enum CodingKeys: String, CodingKey {
                case postId
                case id
                case name
                case email
                case body
            }
        }
        
        struct ViewModel {
            let data: [PostsDetailsModel.Comments.Response]
        }
    }
}
