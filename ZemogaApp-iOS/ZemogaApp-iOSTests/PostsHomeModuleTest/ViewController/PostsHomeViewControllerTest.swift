//
//  PostsHomeViewControllerTest.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 20/3/22.
//

import XCTest
import Foundation
@testable import ZemogaApp_iOS

class PostsHomeViewControllerTest: XCTestCase {
    var sut: PostsHomeViewController!
    var viewControllerMock: PostsHomeDisplayLogicMock!
    
    override func setUp() {
        super.setUp()
        
        viewControllerMock = PostsHomeDisplayLogicMock()
        sut = PostsHomeViewController()
    }
    
    func testGetPostsQuery() {
        //Given
        let responseMock = [PostsHomeModel.Posts.Response(userId: 123, id: 123, title: "ABC", body: "ABC", isSelected: true, isFavorite: true)]
        
        let viewModel = PostsHomeModel.Posts.ViewModel(data: responseMock)
        let queue = DispatchQueue(label: "FileLoaderTests")
        
        viewControllerMock.displayPosts(viewModel: viewModel, on: queue)
        
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

