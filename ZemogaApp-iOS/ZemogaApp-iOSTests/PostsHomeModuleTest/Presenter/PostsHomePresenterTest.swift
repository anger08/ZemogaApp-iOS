//
//  PostsHomePresenterTest.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 21/3/22.
//

import XCTest
import Foundation
@testable import ZemogaApp_iOS

class PostsHomePresenterTest: XCTestCase {
    var sut: PostsHomePresenter!
    var viewControllerMock: PostsHomeDisplayLogicMock!
    
    override func setUp() {
        viewControllerMock = PostsHomeDisplayLogicMock()
        sut = PostsHomePresenter()
        sut.viewController = viewControllerMock
    }
    
    func testPresentPostsSuccess() {
        //Given
        let responseMock = [PostsHomeModel.Posts.Response(userId: 123, id: 123, title: "ABC", body: "ABC", isSelected: true, isFavorite: true)]
        
        let viewModel = PostsHomeModel.Posts.ViewModel(data: [])
        let queue = DispatchQueue(label: "FileLoaderTests")
        viewControllerMock.displayPosts(viewModel: viewModel, on: queue)
        
        //When
        queue.sync {
            sut.presentPosts(response: responseMock)
        }
        
        let result = viewControllerMock.isFunctionWasCalled
        
        //Then
        XCTAssertTrue((result))
    }
    
    func testPresentPostsFailure() {
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
