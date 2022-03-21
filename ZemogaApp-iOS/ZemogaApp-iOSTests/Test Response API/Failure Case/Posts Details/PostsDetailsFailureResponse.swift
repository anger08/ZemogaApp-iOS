//
//  PostsDetailsFailureResponse.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 20/3/22.
//

import XCTest
@testable import ZemogaApp_iOS

class PostsDetailsFailureResponse: XCTestCase {
    var sut: PostsDetailsAPI!
    var postsDetailsServiceProtocolMock: PostsDetailsWorkerMock!
    
    override func setUp() {
        postsDetailsServiceProtocolMock = PostsDetailsWorkerMock()
        sut = PostsDetailsAPI()
    }
    
    //MARK: -- Test GetUsers
    func testGetUsersFailure(){
        //Given
        let requestData = PostsDetailsModel.Users.Request()
        let failure : PostsHomeError = .request
        
        //When
        postsDetailsServiceProtocolMock.resultGetUsers = .failure(failure)
        
        //Then
        sut.getUsers(request: requestData, completion: { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, failure.localizedDescription)
            }
        })
    }
    
    //MARK: -- Test GetComments
    func testGetCommentsFailure(){
        //Given
        let requestData = PostsDetailsModel.Comments.Request()
        let failure : PostsHomeError = .request
        
        //When
        postsDetailsServiceProtocolMock.resultGetComments = .failure(failure)
        
        //Then
        sut.getComments(request: requestData, completion: { result in
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
