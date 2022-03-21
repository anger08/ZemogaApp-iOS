//
//  PostsDetailsViewControllerTest.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 20/3/22.
//

import XCTest
import Foundation
@testable import ZemogaApp_iOS

class PostsDetailsViewControllerTest: XCTestCase {
    var sut: PostsDetailsViewController!
    var viewControllerMock: PostsDetailsDisplayLogicMock!
    
    override func setUp() {
        super.setUp()
        
        viewControllerMock = PostsDetailsDisplayLogicMock()
        sut = PostsDetailsViewController()
    }
    
    func testGetUsersQuery() {
        //Given
        let responseMock = [PostsDetailsModel.Users.Response(id: 123, name: "ABC", email: "SBC", phone: "SBC", website: "ABC")]
        
        let viewModel = PostsDetailsModel.Users.ViewModel(data: responseMock)
        let queue = DispatchQueue(label: "FileLoaderTests")
        
        viewControllerMock.displayUsers(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.loadInitialData()
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
    func testGetCommentsQuery() {
        //Given
        let responseMock = [PostsDetailsModel.Comments.Response(postId: 123, id: 123, name: "ABC", email: "ABC", body: "ABC ")]
        
        let viewModel = PostsDetailsModel.Comments.ViewModel(data: responseMock)
        let queue = DispatchQueue(label: "FileLoaderTests")
        
        viewControllerMock.displayComments(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.loadInitialData()
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
    func testFailure() {
        //Given
        let error: PostsHomeError = .request
        let viewModel = PostsHomeModel.Error.ViewModel(error: error)
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayError(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.displayError(viewModel: viewModel, on: queue)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
}
