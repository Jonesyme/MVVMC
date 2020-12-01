//
//  ViewModel.swift
//  MVVMC
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

protocol ViewModelBindingDelegate: class {
    func updateView(_ errorMessage: String?)
}

//
// MARK: - ViewModel Abstract-Base Class
//
open class ViewModel {
    
    var webSession: WebSession!
    weak var delegate: ViewModelBindingDelegate?
    
    init(webSession: WebSession) {
        self.webSession = webSession
    }
}
