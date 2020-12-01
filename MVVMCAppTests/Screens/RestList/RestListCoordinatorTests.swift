//
//  RestListCoordinatorTests.swift
//  MVVMCTests
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

import XCTest
@testable import MVVMC

class RestListCoordinatorTests: XCTestCase {
    
    var navController: UINavigationController?
    var restListCoordinator: RestListCoordinator?
    
    override func setUp() {
        navController = UINavigationController()
        restListCoordinator = RestListCoordinator(presenter: navController!, webSession: WebSessionMock())
        restListCoordinator?.start()
    }

    func testBasicSetup() throws {
        XCTAssertNotNil(restListCoordinator != nil)
    }
    
    func testTopViewController() throws {
        if navController?.topViewController is RestListViewController {
            XCTAssertTrue(true)
        } else {
            XCTFail()
        }
    }

}
