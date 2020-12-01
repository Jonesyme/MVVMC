//
//  RestListViewModel.swift
//  MVVMC
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

class RestListViewModel: ViewModel {

    private var list = [Restaurant]()

    public var rowCount: Int {
        return list.count
    }
    
    public func item(atRow row: Int) -> Restaurant? {
        if row < 0 || row >= list.count {
            return nil
        }
        return list[row]
    }
    
    public func clearData() {
        list.removeAll()
    }

    public func fetchData() {
        webSession.request(CloverEndpoint.RestaurantList, responseType: [Restaurant].self) { [weak self] result in
            switch result {
            case .error(let error):
                self?.delegate?.updateView(error.description)
            case .success(let response):
                self?.list.append(contentsOf: response)
                self?.delegate?.updateView(nil)
            }
        }
    }
}
