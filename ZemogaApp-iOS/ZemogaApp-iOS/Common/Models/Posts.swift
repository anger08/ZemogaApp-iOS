//
//  Posts.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import UIKit
import Foundation

// MARK: - Response Posts
struct DataPosts: Codable {
    let userId  : Int
    let id      : Int
    let title   : String
    let body    : String
}

struct Users: Codable {
    let id      : Int?
    let name    : String?
    let email   : String?
    let phone   : String?
    let website : String?
}
