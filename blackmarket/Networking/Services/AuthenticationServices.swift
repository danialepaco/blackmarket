//
//  AuthenticationServices.swift
//  ios-base
//
//  Created by Germán Stábile on 6/8/20.
//  Copyright © 2020 Rootstrap Inc. All rights reserved.
//

import Foundation
import RSSwiftNetworking

internal class AuthenticationServices {
    
    enum AuthError: LocalizedError {
        case login
        case signUp
        case logout
        case mapping
        case request
        
        var errorDescription: String? {
            switch self {
            case .login:
                return "authError_login".localized
            case .signUp:
                return "authError_signUp".localized
            case .logout:
                return "authError_logout".localized
            case .mapping:
                return "authError_mapping".localized
            case .request:
                return "authError_request".localized
            }
        }
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
    
    @discardableResult func login(
        email: String,
        password: String
    ) async -> Result<UserData, AuthError> {
        do {
            let response: Response<UserData> = try await apiClient.request(
                endpoint: AuthEndpoint.signIn(email: email, password: password)
            )
            switch response.result {
            case .success(let user):
                if
                    let user = user,
                    await self.saveUserSession(user.data, headers: response.header)
                {
                    return .success(user)
                } else {
                    return .failure(AuthError.mapping)
                }
            case .failure:
                return .failure(AuthError.login)
            }
        } catch let error {
            guard
                let responseError = error.asAFError,
                let errorCode = responseError.responseCode
            else {
                return .failure(AuthError.request)
            }
            switch errorCode {
            case _ where errorCode >= 400:
                return .failure(AuthError.login)
            default:
                return .failure(AuthError.request)
            }
        }
    }
    
    @discardableResult func signup(
        email: String,
        name: String,
        password: String
    ) async -> Result<UserData, AuthError> {
        do {
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
                    await self.saveUserSession(user.data, headers: response.header)
                {
                    return .success(user)
                } else {
                    return .failure(AuthError.mapping)
                }
            case .failure:
                return .failure(AuthError.signUp)
            }
        } catch let error {
            guard
                let responseError = error.asAFError,
                let errorCode = responseError.responseCode
            else {
                return .failure(AuthError.request)
            }
            switch errorCode {
            case _ where errorCode >= 400:
                return .failure(AuthError.signUp)
            default:
                return .failure(AuthError.request)
            }
        }
    }
    
    @discardableResult func logout() async -> Result<Bool, Error> {
        do {
            let response: Response<Network.EmptyResponse> = try await apiClient.request(
                endpoint: AuthEndpoint.logout
            )
            switch response.result {
            case .success:
                userDataManager.deleteUser()
                sessionManager.deleteSession()
                return .success(true)
            case .failure:
                return .failure(AuthError.logout)
            }
        } catch {
            return .failure(AuthError.request)
        }
    }
    
    @MainActor private func saveUserSession(
        _ user: User?,
        headers: [AnyHashable: Any]
    ) -> Bool {
        userDataManager.currentUser = user
        guard let session = Session(headers: headers) else { return false }
        sessionManager.saveUser(session: session)
        
        return userDataManager.currentUser != nil && sessionManager.currentSession?.isValid ?? false
    }
}
