//
//  CloverEndpoint.swift
//  MVVMC
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

import Foundation
import UIKit

//
// MARK: - Clover-Specific WebService Endpoints
//
public enum CloverEndpoint {
    case RestaurantList
}

extension CloverEndpoint: WSEndpointProtocol {
    
    public var scheme: WebSession.RequestScheme {
        return .HTTPS
    }
    
    public var requestMethod: WebSession.RequestMethod {
        return .GET
    }

    public var host: String {
        return "www.json-generator.com"
    }

    public var path: String {
        switch self {
        case .RestaurantList:
            return "/api/json/get/bQwCjWxBDS"
        }
    }
    
    public var params: [URLQueryItem] {
        switch self {
        case .RestaurantList:
            return []
        }
    }

}
