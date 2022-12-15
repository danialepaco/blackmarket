//
//  StateButton.swift
//  blackmarket
//
//  Created by Daniel Parra on 9/28/22.
//

import SwiftUI
import Combine

struct StateButton: View {
    let action: () -> ()
    let title: String
    @State private var isEnabled: Bool = false
    @State private var isLoading: Bool = false
    var isValid: AnyPublisher<Bool, Never> = Just(true).eraseToAnyPublisher()
    let isFetching: AnyPublisher<Bool, Never>

    var body: some View {
        Button(action: {
            withAnimation { action() }
        }) {
            ZStack {
                if isLoading {
                    ProgressView()
                        .tint(isEnabled ? .white : .black)
                } else {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 45)
            .foregroundColor(
                isEnabled ? Color.white : Color.disabledGray
            )
            .background(
                isEnabled ? Color.black : Color.bone
            )
        }
        .cornerRadius(8)
        .disabled(!isEnabled)
        .onReceive(isValid) { isValid in
            isEnabled = isValid
        }
        .onReceive(isFetching) { isFetching in
            isLoading = isFetching
        }
    }
}

struct StateButton_Previews: PreviewProvider {
    static var previews: some View {
        let fetchingSubject = CurrentValueSubject<Bool, Never>(false)
        let isFetching: AnyPublisher<Bool, Never> = fetchingSubject.eraseToAnyPublisher()
        StateButton(action: {}, title: "Button", isFetching: isFetching)
    }
}
