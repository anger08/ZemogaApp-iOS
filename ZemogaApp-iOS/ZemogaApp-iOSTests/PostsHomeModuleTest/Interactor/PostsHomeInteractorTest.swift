//
//  PostsHomeInteractorTest.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 20/3/22.
//

import XCTest
import Foundation
@testable import ZemogaApp_iOS

class PostsHomeInteractorTest: XCTestCase {
    var sut: PostsHomeInteractor!
    var postsPresenterMock: PostsHomeWorkerMock!
    
    override func setUp() {
        postsPresenterMock = PostsHomeWorkerMock()
        sut = PostsHomeInteractor(worker: postsPresenterMock)
    }
    
    func testPostsSuccess() {
        //Given
        let requestData = PostsHomeModel.Posts.Request()
        let responseMock = [PostsHomeModel.Posts.Response(userId: 123, id: 123, title: "ABC", body: "ABC", isSelected: true, isFavorite: true   )]
        
        postsPresenterMock.resultGetPosts = .success(responseMock)
        postsPresenterMock.isFunctionWasCalled = false
        
        //When
        sut.getPosts(request: requestData)
        let result = postsPresenterMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue(result)
    }
    
    func testPostsFailure() {
        //Given
        let requestData = PostsHomeModel.Posts.Request()
        let failure : PostsHomeError = .request

        postsPresenterMock.resultGetPosts = .failure(failure)
        postsPresenterMock.isFunctionWasCalled = false

        //When
        sut.getPosts(request: requestData)
        let result = postsPresenterMock.isFunctionWasCalled

        //Then
        XCTAssertTrue(result)
    }
}
