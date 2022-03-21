//
//  PostsHomeEndpointTest.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 20/3/22.
//

import XCTest
@testable import ZemogaApp_iOS

class PostsHomeEndpointTest: XCTestCase {
    var sut: PostsHomeEndpoint!
    
    //MARK: - GET METHOD
    func testGetPostsHome() {
        sut = .getPosts

        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.path, "posts")
        XCTAssertNil(sut.parameter)
    }
}
