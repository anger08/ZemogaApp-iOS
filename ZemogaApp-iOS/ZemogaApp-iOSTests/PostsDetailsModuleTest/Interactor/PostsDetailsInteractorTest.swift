//
//  PostsDetailsInteractorTest.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 21/3/22.
//

import XCTest
import Foundation
@testable import ZemogaApp_iOS

class PostsDetailsInteractorTest: XCTestCase {
    var sut: PostsDetailsInteractor!
    var sut2: PostsDetailsInteractor!
    var usersPresenterMock: PostsDetailsWorkerMock!
    var commentsPresenterMock: PostsDetailsWorkerMock!
    
    override func setUp() {
        usersPresenterMock = PostsDetailsWorkerMock()
        sut = PostsDetailsInteractor(worker: usersPresenterMock)
        
        commentsPresenterMock = PostsDetailsWorkerMock()
        sut2 = PostsDetailsInteractor(worker: commentsPresenterMock)
    }
    
    func testUsersSuccess() {
        //Given
        let requestData = PostsDetailsModel.Users.Request()
        let responseMock = [PostsDetailsModel.Users.Response(id: 123, name: "ABC", email: "ABC", phone: "ABC", website: "ABC")]
        
        usersPresenterMock.resultGetUsers = .success(responseMock)
        usersPresenterMock.isFunctionWasCalled = false
        
        //When
        sut.getUsers(request: requestData)
        let result = usersPresenterMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue(result)
    }
    
    func testUsersFailure() {
        //Given
        let requestData = PostsDetailsModel.Users.Request()
        let failure : PostsHomeError = .request

        usersPresenterMock.resultGetUsers = .failure(failure)
        usersPresenterMock.isFunctionWasCalled = false

        //When
        sut.getUsers(request: requestData)
        let result = usersPresenterMock.isFunctionWasCalled

        //Then
        XCTAssertTrue(result)
    }
    
    func testCommentsSuccess() {
        //Given
        let requestData = PostsDetailsModel.Comments.Request()
        let responseMock = [PostsDetailsModel.Comments.Response(postId: 123, id: 123, name: "ABC", email: "ABC", body: "ABC")]
        
        commentsPresenterMock.resultGetComments = .success(responseMock)
        commentsPresenterMock.isFunctionWasCalled = false
        
        //When
        sut2.getComments(request: requestData)
        let result = commentsPresenterMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue(result)
    }
    
    func testCommentsFailure() {
        //Given
        let requestData = PostsDetailsModel.Comments.Request()
        let failure : PostsHomeError = .request

        commentsPresenterMock.resultGetComments = .failure(failure)
        commentsPresenterMock.isFunctionWasCalled = false

        //When
        sut2.getComments(request: requestData)
        let result = commentsPresenterMock.isFunctionWasCalled

        //Then
        XCTAssertTrue(result)
    }
}

