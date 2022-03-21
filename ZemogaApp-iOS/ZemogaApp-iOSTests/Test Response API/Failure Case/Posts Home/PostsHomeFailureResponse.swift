//
//  PostsHomeFailureResponse.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 20/3/22.
//

import XCTest
@testable import ZemogaApp_iOS

class PostsHomeFailureResponse: XCTestCase {
    var sut: PostsAPI!
    var postsHomeServiceProtocolMock: PostsHomeWorkerMock!
    
    override func setUp() {
        postsHomeServiceProtocolMock = PostsHomeWorkerMock()
        sut = PostsAPI()
    }
    
    //MARK: -- Test Posts
    func testGetPostsFailure(){
        //Given
        let requestData = PostsHomeModel.Posts.Request()
        let failure : PostsHomeError = .request
        
        //When
        postsHomeServiceProtocolMock.resultGetPosts = .failure(failure)
        
        //Then
        sut.getPosts(request: requestData, completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, failure.localizedDescription)
            }
        })
    }
}
