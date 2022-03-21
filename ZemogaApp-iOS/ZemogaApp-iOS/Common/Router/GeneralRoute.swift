//
//  GeneralRoute.swift
//  ZemogaApp-iOS
//
//  Created by Angelber Castro on 18/3/22.
//

import Foundation
import UIKit

enum GeneralRoute: IRouter {
    case postsHome
}

extension GeneralRoute {
    var scene: UIViewController? {
        switch self {
        case .postsHome:
            return PostsHomeViewController()
        }
    }
}
