//
//  WebSession.swift
//  MVVMC
//
//  Created by Mike Jones on 10/31/20.
//  Copyright © 2020 Michael Jones. All rights reserved.
//

import Foundation

//
// MARK: - General Purpose WebService Session
//
public class WebSession {

    public enum RequestMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }

    public enum RequestScheme: String {
        case HTTP
        case HTTPS
    }

    public enum Response<T: Decodable> {
        case success(T)
        case error(WSError)
    }
    
    public enum WSError: Error {
        case urlFormat
        case unknown
        case badResponse(Int)
        case network(Error)
        case parser(Error)
        
        var description: String {
            switch self {
            case .urlFormat: return "Unable to generate request"
            case .unknown: return "Unknown error"
            case .badResponse(let code): return "Bad response: \(code)"
            case .network(let error): return "Networking error: " + error.localizedDescription
            case .parser(let error): return "Parsing error: \(error)"
            }
        }
    }
    
    public typealias CompletionHandler<T:Decodable> = (WebSession.Response<T>) -> Void
    
    lazy private var session: URLSession = {
        var configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.timeoutIntervalForRequest = 20
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    func generateRequest(_ endpoint: WSEndpointProtocol) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme.rawValue
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.params
        guard let url = urlComponents.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.requestMethod.rawValue
        return request
    }

    func decode<T:Decodable>(with data: Data, decodingType: T.Type) -> WebSession.Response<T> {
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedObject)
        } catch {
            return .error(WSError.parser(error))
        }
    }

    @discardableResult public func request<T:Decodable>(_ endpoint: WSEndpointProtocol, responseType: T.Type, callback: @escaping WebSession.CompletionHandler<T>) -> URLSessionDataTask? {
        var task: URLSessionDataTask? = nil
        guard let request = generateRequest(endpoint) else {
            DispatchQueue.main.async {
                callback(.error(WSError.urlFormat))
            }
            return task
        }
        
        task = session.dataTask(with: request) { data, response, error in
            if let errorMessage = error {
                DispatchQueue.main.async {
                    callback(.error(WSError.network(errorMessage)))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                DispatchQueue.main.async {
                    callback(.error(WSError.unknown))
                }
                return
            }
            guard httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    callback(.error(WSError.badResponse(httpResponse.statusCode)))
                }
                return
            }
            
            let decoded = self.decode(with: data, decodingType: T.self)

            DispatchQueue.main.async {
                switch decoded {
                case .success(let result):
                    callback(.success(result))
                case .error(let error):
                    callback(.error(error))
                }
            }
        }
        task?.resume()
        return task // allow caller to cancel request
    }
}

