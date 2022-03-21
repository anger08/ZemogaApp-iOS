//
//  PostsDetailsPresenterTest.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 20/3/22.
//

import XCTest
import Foundation
@testable import ZemogaApp_iOS

class PostsDetailsPresenterTest: XCTestCase {
    var sut: PostsDetailsPresenter!
    var viewControllerMock: PostsDetailsDisplayLogicMock!
    
    override func setUp() {
        viewControllerMock = PostsDetailsDisplayLogicMock()
        sut = PostsDetailsPresenter()
        sut.viewController = viewControllerMock
    }
    
    func testPresentUsersSuccess() {
        //Given
        let responseMock = [PostsDetailsModel.Users.Response(id: 123, name: "ABC", email: "ABC", phone: "ABC", website: "ABC")]
        
        let viewModel = PostsDetailsModel.Users.ViewModel(data: [])
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayUsers(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.presentUsers(response: responseMock)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
    func testPresentCommentsSuccess() {
        //Given
        let responseMock = [PostsDetailsModel.Comments.Response(postId: 123, id: 123, name: "ABC", email: "ABC", body: "ABC")]
        
        let viewModel = PostsDetailsModel.Comments.ViewModel(data: [])
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayComments(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.presentComments(response: responseMock)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
    func testPresentFailure() {
        //Given
        let error: PostsHomeError = .request
        let responseMock = PostsHomeModel.Error.Response(error: error)
        let viewModel = PostsHomeModel.Error.ViewModel(error: error)
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayError(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.presentError(response: responseMock)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
}
