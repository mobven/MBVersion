//
//  NetworkLogger.swift
//
//
//  Created by Semih Ozsoy on 17.10.2024.
//

import Foundation

public final class NetworkLogger: URLProtocol {
    
    public static let shared = NetworkLogger()
    
   private override init(
    request: URLRequest,
    cachedResponse: CachedURLResponse?,
    client: (any URLProtocolClient)?) {
       super.init(request: request, cachedResponse: cachedResponse, client: client)
    }
    
    public static var result: NetworkLogger.NetworkResult?
    
    public override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    public override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    public override func startLoading() {
        guard let result = NetworkLogger.result else {
            client?.urlProtocolDidFinishLoading(self)
            return
        }
        switch result {
        case let .success(data):
            client?.urlProtocol(self, didLoad: data)
        case let .failure(error):
            client?.urlProtocol(self, didFailWithError: error)
        case let .failureStatusCode(statusCode):
            if let url = request.url,
               let response = HTTPURLResponse(
                url: url, statusCode: statusCode,
                httpVersion: nil, headerFields: nil) {
                client?.urlProtocol(
                    self,
                    cachedResponseIsValid: CachedURLResponse(response: response, data: Data()))
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    public override func stopLoading() {
        // nothing to handle
    }
}

extension NetworkLogger {
    public enum NetworkResult {
        /// Successfull result with specified data
        case success(Data)
        /// Failure with the specified Error.
        case failure(Error)
        /// Failure with the specified status code.
        case failureStatusCode(Int)
    }
}

