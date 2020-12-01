//
//  Observable.swift
//  MVVMC
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

import Foundation

//
// MARK: - Basic Observable
//
class Observable<T> {
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged?(self.value!)
            }
        }
    }
    var valueChanged: ((T) -> Void)?
    
}
