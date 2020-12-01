//
//  AppCoordinator.swift
//  MVVMC
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

//
// MARK: - Primary Coordinator for App
//
class AppCoordinator: Coordinator {
    
    let window: UIWindow
    let webSession: WebSession
    let rootViewController: UINavigationController
    var restListCoordinator: RestListCoordinator

    init(window: UIWindow) {
        self.window = window
        webSession = WebSession()
        rootViewController = UINavigationController()
        restListCoordinator = RestListCoordinator(presenter: rootViewController, webSession: webSession)
    }

    func start() {
        window.rootViewController = rootViewController
        restListCoordinator.start()
        window.makeKeyAndVisible()
    }
}
