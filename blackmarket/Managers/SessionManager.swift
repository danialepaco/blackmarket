//
//  SessionDataManager.swift
//  ios-base
//
//  Created by Juan Pablo Mazza on 11/8/16.
//  Copyright © 2016 Rootstrap Inc. All rights reserved.
//

import UIKit
import Combine
import SwiftUI

internal class SessionManager: CurrentUserSessionProvider {
    
    @Published var isSessionValid = false
    
    var subscriptions = Set<AnyCancellable>()
    
    static let SESSIONKEY = "ios-base-session"
    
    static let shared = SessionManager()
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        userDefaults
            .publisher(for: \.currentSession)
            .handleEvents(receiveOutput: { [weak self] currentSession in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.isSessionValid = self.validSession(session: currentSession)
                }
            })
            .sink { _ in }
            .store(in: &subscriptions)
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
            userDefaults.currentSession = newValue
        }
    }
    
    func deleteSession() {
        userDefaults.removeObject(forKey: SessionManager.SESSIONKEY)
    }
    
    func validSession(session: Session?) -> Bool {
        guard let session = session, let uid = session.uid,
              let token = session.accessToken, let client = session.client else {
            return false
        }
        return !uid.isEmpty && !token.isEmpty && !client.isEmpty
    }
}


extension UserDefaults {
    @objc dynamic var currentSession: Session? {
        get {
            if
                let data = data(forKey: SessionManager.SESSIONKEY),
                let session = try? JSONDecoder().decode(Session.self, from: data)
            {
                return session
            }
            return nil
        }
        set {
            let session = try? JSONEncoder().encode(newValue)
            set(session, forKey: SessionManager.SESSIONKEY)
        }
    }
}
