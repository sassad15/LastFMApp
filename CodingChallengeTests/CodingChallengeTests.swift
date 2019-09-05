//
//  CodingChallengeTests.swift
//  CodingChallengeTests
//
//  Created by muhammad on 8/30/19
//  Copyright © 2019 muhammad. All rights reserved.
//

import XCTest
@testable import CodingChallenge

class CodingChallengeTests: XCTestCase {
    
    var viewModel: ViewModel!

    override func setUp() {
        
        super.setUp()
        viewModel = ViewModel()
    }

    override func tearDown() {
        
        viewModel = nil
        super.tearDown()
    }

    func testContentCount() {
        
        
        
        viewModel.artistLimit = 0
        
       
        viewModel.resetLimits()
        
        
        XCTAssertEqual(viewModel.artistLimit, 5)
    }

    func testServiceCall() {
        
        
        var myAlbums = [Album]()
        
        
        let promise = expectation(description: "receiving content..")
        
        
        ContentService.shared.getAlbums(search: "Drake", limit: 10) { albums in
            
            myAlbums = albums
            promise.fulfill()
        }
        
        
        waitForExpectations(timeout: 3, handler: nil)
        
        
        XCTAssertTrue(myAlbums.count > 0)
        XCTAssertEqual(myAlbums.count, 10)
        
        
        self.measure {
            viewModel.getContent(with: "Nas")
        }
    }

}
