//
//  Restaurant.swift
//  MVVMC
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

//
// MARK: - Restaurant Codable
//
struct Restaurant: Codable {
    var id: Int64
    var name: String?
    var category: String?
    var description: String?
}
