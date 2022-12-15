//
//  LogoutViewModel.swift
//  blackmarket
//
//  Created by Daniel Parra on 12/6/22.
//

import Foundation
import Combine

class LogoutViewModel: ObservableObject, Identifiable {
    
    private let isFetchingSubject = CurrentValueSubject<Bool, Never>(false)
    private let errorSubject = CurrentValueSubject<String, Never>("")
    private let authServices: AuthenticationServices
    
    var errorPublisher: AnyPublisher<String, Never> {
        errorSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    var isFetchingPublisher: AnyPublisher<Bool, Never> {
        isFetchingSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    init(authServices: AuthenticationServices = AuthenticationServices()) {
        self.authServices = authServices
    }
    
    func logOut() async {
        isFetchingSubject.send(true)
        let _ = await authServices.logout()
        isFetchingSubject.send(false)
    }
}
