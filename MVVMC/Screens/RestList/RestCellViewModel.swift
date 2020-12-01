//
//  RestCellViewModel.swift
//  MVVMC
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

class RestCellViewModel {

    var name: Observable<String> = Observable()
    var category: Observable<String> = Observable()
    var description: Observable<String> = Observable()

    init(_ restaurant: Restaurant) {
        self.name.value = restaurant.name
        self.category.value = restaurant.category
        self.description.value = restaurant.description
    }
}
