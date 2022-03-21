//
//  PostsHomeEndpoint.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import Foundation
import Alamofire

enum PostsHomeEndpoint {
    case getPosts
}

extension PostsHomeEndpoint: ZAEndpoint {
    var method: HTTPMethod {
        switch self {
        case .getPosts:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getPosts:
            return "posts"
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .getPosts:
            return nil
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .getPosts:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
