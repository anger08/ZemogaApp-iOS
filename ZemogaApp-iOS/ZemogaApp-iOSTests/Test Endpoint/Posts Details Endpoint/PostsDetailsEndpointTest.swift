//
//  PostsDetailsEndpointTest.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 20/3/22.
//

import XCTest
@testable import ZemogaApp_iOS

class PostsDetailsEndpointTest: XCTestCase {
    var sut: PostsDetailsEndpoint!
    
    //MARK: - GET METHOD
    func testGetPostsUsers() {
        sut = .getUsers

        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.path, "users")
        XCTAssertNil(sut.parameter)
    }
    
    func testGetPostsComments() {
        sut = .getComments

        XCTAssertEqual(sut.method, .get)
        XCTAssertEqual(sut.path, "comments")
        XCTAssertNil(sut.parameter)
    }
}
