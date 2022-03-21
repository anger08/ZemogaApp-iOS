//
//  PostsDetailsEndpoint.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import Foundation
import Alamofire

enum PostsDetailsEndpoint {
    case getUsers
    case getComments
}

extension PostsDetailsEndpoint: ZAEndpoint {
    var method: HTTPMethod {
        switch self {
        case .getUsers, .getComments:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "users"
        case .getComments:
            return "comments"
        }
    }
    
    var parameter: Parameters? {
        switch self {
        case .getUsers, .getComments:
            return nil
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .getUsers, .getComments:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
}

