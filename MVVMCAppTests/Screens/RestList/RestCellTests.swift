//
//  RestCellTests.swift
//  MVVMCTests
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

import XCTest
@testable import MVVMC

class RestCellTests: XCTestCase {
    
    var restListViewController: RestListViewController?
    var restListViewModel: RestListViewModel?
    var restCell: RestCell?
    
    override func setUpWithError() throws {
        restListViewModel = RestListViewModel(webSession: WebSessionMock())
        restListViewController = RestListViewController.createFromStoryboard(viewModel: restListViewModel!)
        _ = restListViewController?.view
        
        delay {
            self.restCell = self.restListViewController?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? RestCell
        }
    }
    
    func testCellViewSetup() throws {
        let cell = self.restListViewController?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? RestCell
        XCTAssert(cell != nil)
    }
    
    func testRowCount() throws {
        let rowCount = self.restListViewController?.tableView.numberOfRows(inSection: 0)
        XCTAssert(rowCount == 5)
    }
    
    func testCellPopulation() throws {
        let cell = self.restListViewController?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? RestCell
        delay {
            XCTAssert(cell?.nameLabel.text == "Restaurant 1")
            XCTAssert(cell?.categoryLabel.text == "fast food")
            XCTAssert(cell?.descriptionLabel.text == "This is the test description for restaurant 1")
        }
    }

    func testCellViewModelBinding() throws {
        let cell = self.restListViewController?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? RestCell
        cell?.viewModel?.name.value = "Test1"
        cell?.viewModel?.category.value = "Test2"
        cell?.viewModel?.description.value = "Test3"
        delay {
            XCTAssert(cell?.nameLabel.text == "Test1")
            XCTAssert(cell?.categoryLabel.text == "Test2")
            XCTAssert(cell?.descriptionLabel.text == "Test3")
        }
    }
    
}
