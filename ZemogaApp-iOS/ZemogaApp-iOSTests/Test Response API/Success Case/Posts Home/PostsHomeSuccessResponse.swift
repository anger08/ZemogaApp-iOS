//
//  PostsHomeSuccessResponse.swift
//  ZemogaApp-iOSTests
//
//  Created by Angelber Castro on 20/3/22.
//

import XCTest
@testable import ZemogaApp_iOS

class PostsHomeSuccessResponse: XCTestCase {
    var sut: PostsAPI!
    var postsHomeServiceProtocolMock: PostsHomeWorkerMock!
    
    override func setUp() {
        postsHomeServiceProtocolMock = PostsHomeWorkerMock()
        sut = PostsAPI()
    }
    
    //MARK: -- Test GetPosts
    func testGetPostsSuccess(){
        //Given
        let requestData = PostsHomeModel.Posts.Request()
        let dataMock = PostsHomeModel.Posts.Response(userId: 123, id: 123, title: "ABC", body: "ABC", isSelected: true, isFavorite: true)
        let success : [PostsHomeModel.Posts.Response]? = .some([dataMock])
        
        //When
        postsHomeServiceProtocolMock.resultGetPosts = .success(success!)
        
        //Then
        sut.getPosts(request: requestData, completion: { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response[0].id, dataMock.id)
                XCTAssertEqual(response[0].userId, dataMock.userId)
                XCTAssertEqual(response[0].title, dataMock.title)
                XCTAssertEqual(response[0].body, dataMock.body)
                XCTAssertEqual(response[0].isFavorite, dataMock.isFavorite)
                XCTAssertEqual(response[0].isSelected, dataMock.isSelected)
            case .failure(_):
                break
            }
        })
    }
}
