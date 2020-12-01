//
//  RestListCoordinator.swift
//  MVVMC
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

import UIKit

class RestListCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private let webSession: WebSession
    
    init(presenter: UINavigationController, webSession: WebSession) {
        self.presenter = presenter
        self.webSession = webSession
    }

    func start() {
        let restListViewModel = RestListViewModel(webSession: webSession)
        let restListViewController = RestListViewController.createFromStoryboard(viewModel: restListViewModel)
        presenter.pushViewController(restListViewController, animated: true)
    }
}
