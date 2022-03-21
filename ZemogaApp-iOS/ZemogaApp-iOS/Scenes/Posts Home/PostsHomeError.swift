//
//  PostsHomeError.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import Foundation

enum PostsHomeError: Error, CustomStringConvertible {
    case request
    case network(Error)
    case parse(Error)
    case server(description: String)
    
    var description: String {
        switch self {
        case .network(let error), .parse(let error):
            return error.localizedDescription
        case .request:
            return "Error request"
        case .server(let description):
            return description
        }
    }
}
