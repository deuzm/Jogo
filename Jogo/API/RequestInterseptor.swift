//
//  RequestInterseptor.swift
//  Jogo
//
//  Created by Лиза  Малиновская on 3/3/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import Foundation

import Alamofire
import SwiftKeychainWrapper

protocol AccessTokenStorage: class {
    typealias JWT = String
    var accessToken: JWT { get set }
}

final class RequestInterceptor: Alamofire.RequestInterceptor {
    
    private let storage: AccessTokenStorage
    
    init(storage: AccessTokenStorage) {
        self.storage = storage
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix("https://jogtracker.herokuapp.com") == true else {
            return completion(.success(urlRequest))
        }
        var urlRequest = urlRequest
        urlRequest.headers.update(.authorization(bearerToken: storage.accessToken))
        
        completion(.success(urlRequest))
    }
    
//    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
//            /// The request did not fail due to a 401 Unauthorized response.
//            /// Return the original error and don't retry the request.
//            return completion(.doNotRetryWithError(error))
//        }
//
//        refreshToken { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .success(let token):
//                self.storage.accessToken = token
//                /// After updating the token we can safily retry the original request.
//                completion(.retry)
//            case .failure(let error):
//                completion(.doNotRetryWithError(error))
//            }
//        }
//    }
    
    
//    struct TokenResponse: Decodable {
//        var identity: String
//        var token: String
//    }
//
//    func refreshToken(result: ) {
//
//        let parameters = ["uuid":"hello"]
//        AF.request("https://jogtracker.herokuapp.com/api/v1/auth/uuidLogin", method: .post, parameters: parameters).response {
//            response in
//            debugPrint(response)
//        }
//
//    }
}

class KeyChainStorage: AccessTokenStorage {
    var accessToken: JWT
    init() {
        accessToken = KeychainWrapper.standard.string(forKey: "accessToken") ?? ""
    }
    
    func removeAccessToken() -> Bool {
        KeychainWrapper.standard.removeObject(forKey: "accessToken")
    }
    
    func addAccessToken(value: String) -> Bool {
        KeychainWrapper.standard.set(value, forKey: "accessToken")
    }
    
}

let storage = KeyChainStorage()
let interceptor = RequestInterceptor(storage: storage)
let AF = Session(interceptor: interceptor)
