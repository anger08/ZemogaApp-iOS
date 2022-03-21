//
//  PostsDetailsSuccessResponse.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 20/3/22.
//

import XCTest
@testable import ZemogaApp_iOS

class PostsDetailsSuccessResponse: XCTestCase {
    var sut: PostsDetailsAPI!
    var postsDetailsServiceProtocolMock: PostsDetailsWorkerMock!
    
    override func setUp() {
        postsDetailsServiceProtocolMock = PostsDetailsWorkerMock()
        sut = PostsDetailsAPI()
    }
    
    //MARK: -- Test GetUsers
    func testGetUsersSuccess(){
        //Given
        let requestData = PostsDetailsModel.Users.Request()
        let dataMock = PostsDetailsModel.Users.Response(id: 123, name: "ABC", email: "ABC", phone: "ABC", website: "ABC")
        let success : [PostsDetailsModel.Users.Response]? = .some([dataMock])
        
        //When
        postsDetailsServiceProtocolMock.resultGetUsers = .success(success!)
        
        //Then
        sut.getUsers(request: requestData, completion: { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response[0].id, dataMock.id)
                XCTAssertEqual(response[0].name, dataMock.name)
                XCTAssertEqual(response[0].email, dataMock.email)
                XCTAssertEqual(response[0].phone, dataMock.phone)
                XCTAssertEqual(response[0].website, dataMock.website)
            case .failure(_):
                break
            }
        })
    }
    
    //MARK: -- Test GetComments
    func testGetCommentsSuccess(){
        //Given
        let requestData = PostsDetailsModel.Comments.Request()
        let dataMock = PostsDetailsModel.Comments.Response(postId: 123, id: 123, name: "ABC", email: "ABC", body: "ABC")
        let success : [PostsDetailsModel.Comments.Response]? = .some([dataMock])
        
        //When
        postsDetailsServiceProtocolMock.resultGetComments = .success(success!)
        
        //Then
        sut.getComments(request: requestData, completion: { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response[0].postId, dataMock.postId)
                XCTAssertEqual(response[0].id, dataMock.id)
                XCTAssertEqual(response[0].name, dataMock.name)
                XCTAssertEqual(response[0].email, dataMock.email)
                XCTAssertEqual(response[0].body, dataMock.body)
            case .failure(_):
                break
            }
        })
    }
}
