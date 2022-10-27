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
    private let userDataManager: UserDataManager
    
    private let apiClient: Client
    
    init(
        sessionManager: SessionManager = .shared,
        userDataManager: UserDataManager = .shared,
        apiClient: Client = .shared
    ) {
        self.sessionManager = sessionManager
        self.userDataManager = userDataManager
        self.apiClient = apiClient
    }
    
    func login(
        email: String,
        password: String
    ) async throws -> Result<UserData, Error> {
        let response: Response<UserData> = try await apiClient.request(
            endpoint: AuthEndpoint.signIn(email: email, password: password)
        )
        switch response.result {
        case .success(let user):
            if
                let user = user,
                self.saveUserSession(user.data, headers: response.header)
            {
                return .success(user)
            } else {
                return .failure(AuthError.userSessionInvalid)
            }
        case .failure:
            return .failure(AuthError.userSessionInvalid)
        }
    }
    
    func signup(
        email: String,
        name: String,
        password: String
    ) async throws -> Result<UserData, Error> {
        
        let response: Response<UserData> = try await apiClient.request(
            endpoint: AuthEndpoint.signUp(
                email: email,
                name: name,
                password: password
            )
        )
        
        switch response.result {
        case .success(let user):
            if
                let user = user,
                self.saveUserSession(user.data, headers: response.header)
            {
                return .success(user)
            } else {
                return .failure(AuthError.userSessionInvalid)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func logout() async throws -> Result<Bool, Error> {
        let response: Response<Network.EmptyResponse> = try await apiClient.request(
            endpoint: AuthEndpoint.logout
        )
        switch response.result {
        case .success:
            userDataManager.deleteUser()
            sessionManager.deleteSession()
            return .success(true)
        case .failure:
            return .failure(AuthError.userSessionInvalid)
        }
    }
    
    private func saveUserSession(
        _ user: User?,
        headers: [AnyHashable: Any]
    ) -> Bool {
        userDataManager.currentUser = user
        sessionManager.currentSession = Session(headers: headers)
        
        return userDataManager.currentUser != nil && sessionManager.isSessionValid
    }
}
