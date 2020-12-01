//
//  WebSessionMock.swift
//  MVVMCTests
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

import XCTest
@testable import MVVMC

//
// MARK: Mockable WebSession Class
//
class WebSessionMock: WebSession {

    init(_ filename: String = "Response-Success") {
        super.init()
        responseFileName = filename
    }
    
    public var responseFileName: String = ""
    
    @discardableResult override func request<T:Decodable>(_ endpoint: WSEndpointProtocol, responseType: T.Type, callback: @escaping WebSession.CompletionHandler<T>) -> URLSessionDataTask? {
        
        let path = Bundle(for: type(of: self)).path(forResource: responseFileName, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
        let decoded = self.decode(with: data, decodingType: T.self)

        DispatchQueue.main.async {
            switch decoded {
            case .success(let result):
                callback(.success(result))
            case .error(let error):
                callback(.error(error))
            }
        }
        return nil
    }
}

