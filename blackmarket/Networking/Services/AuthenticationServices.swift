//
//  AuthenticationServices.swift
//  ios-base
//
//  Created by Germán Stábile on 6/8/20.
//  Copyright © 2020 Rootstrap Inc. All rights reserved.
//

import RSSwiftNetworking

internal class AuthenticationServices {
    
    enum AuthError: Error {
        case userSessionInvalid
    }
    
    // MARK: - Properties
        
    private let sessionManager: SessionManager
    
    private let apiClient: APIClient
    
    init(
        sessionManager: SessionManager = .shared,
        apiClient: APIClient = Client.shared
    ) {
        self.sessionManager = sessionManager
        self.apiClient = apiClient
    }
    
    func login(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        apiClient.request(
            endpoint: AuthEndpoint.signIn(email: email, password: password)
        ) { [weak self] (result: Result<User?, Error>, responseHeaders: [AnyHashable: Any]) in
            switch result {
            case .success(let user):
                if self?.saveUserSession(user, headers: responseHeaders) ?? false {
                    completion(.success(()))
                } else {
                    completion(.failure(AuthError.userSessionInvalid))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func signup(
        email: String,
        name: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        let endpoint = AuthEndpoint.signUp(
            email: email,
            name: name,
            password: password
        )
        
        apiClient.request(endpoint: endpoint, completion: { [weak self] (result: Result<User?, Error>, responseHeaders: [AnyHashable: Any]) in
            switch result {
            case .success(let user):
                if
                    let user = user,
                    self?.saveUserSession(user, headers: responseHeaders) ?? false
                {
                    completion(.success(user))
                } else {
                    completion(.failure(AuthError.userSessionInvalid))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        apiClient.request(
            endpoint: AuthEndpoint.logout
        ) { [weak self] (result: Result<Network.EmptyResponse?, Error>, _) in
            switch result {
            case .success:
                UserDataManager.deleteUser()
                self?.sessionManager.deleteSession()
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func saveUserSession(
        _ user: User?,
        headers: [AnyHashable: Any]
    ) -> Bool {
        UserDataManager.currentUser = user
        sessionManager.currentSession = Session(headers: headers)
        
        return UserDataManager.currentUser != nil && sessionManager.validSession
    }
}
