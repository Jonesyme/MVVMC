//
//  RestListViewControllerTests.swift
//  MVVMCTests
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

import XCTest
@testable import MVVMC

class RestListViewControllerTests: XCTestCase {

    var restListViewModel: RestListViewModel?
    var restListViewController: RestListViewController?
    
    override func setUpWithError() throws {
        restListViewModel = RestListViewModel(webSession: WebSessionMock())
        restListViewController = RestListViewController.createFromStoryboard(viewModel: restListViewModel!)
        _ = restListViewController?.view
    }

    func testViewSetup() throws {
        delay {
            XCTAssert(self.restListViewController?.view != nil)
            XCTAssert(self.restListViewController?.tableView != nil)
            XCTAssert(self.restListViewController?.tableView.numberOfRows(inSection: 0) == 5)
        }
    }

    func testViewModelBinding() throws {
        restListViewModel?.clearData()
        restListViewController?.updateView()
        delay {
            XCTAssert(self.restListViewController?.tableView.numberOfRows(inSection: 0) == 5)
        }
    }
}

