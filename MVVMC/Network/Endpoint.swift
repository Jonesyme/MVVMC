//
//  Endpoint.swift
//  MVVMC
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

import Foundation

//
// MARK: - Generic WebService Endpoint List
//
public protocol WSEndpointProtocol {
    var scheme: WebSession.RequestScheme { get }
    var requestMethod: WebSession.RequestMethod { get }
    var host: String { get }
    var path: String { get }
    var params: [URLQueryItem] { get }
}
