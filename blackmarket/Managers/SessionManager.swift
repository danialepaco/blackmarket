//
//  SessionDataManager.swift
//  ios-base
//
//  Created by Juan Pablo Mazza on 11/8/16.
//  Copyright © 2016 Rootstrap Inc. All rights reserved.
//

import UIKit
import Combine

internal class SessionManager: CurrentUserSessionProvider {
    
    static let Authenticated = PassthroughSubject<Bool, Never>()
    
    static func IsAuthenticated() -> Bool {
        return SessionManager.shared.validSession
    }
    
    static let SESSIONKEY = "ios-base-session"
    
    static let shared = SessionManager()
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    var currentSession: Session? {
        get {
            if
                let data = userDefaults.data(forKey: SessionManager.SESSIONKEY),
                let session = try? JSONDecoder().decode(Session.self, from: data)
            {
                return session
            }
            return nil
        }
        
        set {
            let session = try? JSONEncoder().encode(newValue)
            userDefaults.set(session, forKey: SessionManager.SESSIONKEY)
        }
    }
    
    func deleteSession() {
        userDefaults.removeObject(forKey: SessionManager.SESSIONKEY)
    }
    
    var validSession: Bool {
        if let session = currentSession, let uid = session.uid,
           let token = session.accessToken, let client = session.client {
            return !uid.isEmpty && !token.isEmpty && !client.isEmpty
        }
        return false
    }
}
