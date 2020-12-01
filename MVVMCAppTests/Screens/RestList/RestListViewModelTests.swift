//
//  RestListViewModelTests.swift
//  MVVMCTests
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

import XCTest
@testable import MVVMC

class RestListViewModelTests: XCTestCase {
    
    var restListViewModel: RestListViewModel?
    var restListViewController: RestListViewController?
    
    override func setUpWithError() throws {
        restListViewModel = RestListViewModel(webSession: WebSessionMock())
        restListViewController = RestListViewController.createFromStoryboard(viewModel: restListViewModel!)
        _ = restListViewController?.view
    }

    func testViewSetup() throws {
        delay {
            XCTAssert(self.restListViewController?.tableView.numberOfRows(inSection: 0) == 5)
        }
    }

    func testClearData() throws {
        restListViewModel?.clearData()
        XCTAssert(self.restListViewModel?.rowCount == 0)
        XCTAssert(self.restListViewModel?.item(atRow: 0) == nil)
    }

}

