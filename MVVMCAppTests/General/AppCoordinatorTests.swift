//
//  AppCoordinatorTests.swift
//  MVVMCTests
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

import XCTest
@testable import MVVMC

class AppCoordinatorTests: XCTestCase {
    
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    
    override func setUp() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        self.appCoordinator = AppCoordinator(window: window)
        self.appCoordinator?.start()
    }

    func testBasicSetup() throws {
        XCTAssertNotNil(appCoordinator?.window)
        XCTAssertNotNil(appCoordinator?.rootViewController)
    }
    
    func testStart() throws {
        XCTAssertNotNil(window?.rootViewController)
        XCTAssert(window?.isKeyWindow == true)
    }
    
    func testRestListCoordinatorStartInvoked() {
        let spy = RestListCoordinatorSpy(presenter: window?.rootViewController as! UINavigationController, webSession: WebSession())
        appCoordinator?.restListCoordinator = spy
        appCoordinator?.start()
        XCTAssert(spy.startInvoked == true)
    }

}


//
//  MARK: Spy Classes
//
class RestListCoordinatorSpy: RestListCoordinator {
    public var startInvoked = false
    override func start() {
        startInvoked = true
    }
}
