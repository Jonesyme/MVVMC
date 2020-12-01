//
//  WebSessionTests.swift
//  MVVMCTests
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

import XCTest
@testable import MVVMC

class WebSessionTests: XCTestCase {
    
    func testSuccessfulRequest() throws {
        let webSession = WebSessionMock("Response-Success")
        var responseArray = [Restaurant]()
        let expectation = self.expectation(description: "MockRequest")
        webSession.request(CloverEndpoint.RestaurantList, responseType: [Restaurant].self) { result in
            switch result {
            case .error(_):
                XCTFail()
            case .success(let response):
                responseArray.append(contentsOf: response)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(responseArray.count == 5)
        XCTAssert(responseArray[0].id == 1)
    }

    func testFailedRequest() throws {
        let webSession = WebSessionMock("Response-Failure")
        var errorMsg = ""
        let expectation = self.expectation(description: "MockRequest")
        webSession.request(CloverEndpoint.RestaurantList, responseType: [Restaurant].self) { result in
            switch result {
            case .error(let error):
                errorMsg = error.description
                expectation.fulfill()
            case .success(_):
                XCTFail()
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(errorMsg.range(of: "Parsing error") != nil)
    }

}
