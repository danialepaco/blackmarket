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
    let isValid: AnyPublisher<Bool, Never>

    var body: some View {
            Button(action: {
                withAnimation {
                    action()
                }
            }) {
                Text(title)
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, maxHeight: 45)
                    .fontWeight(.bold)
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
    }
}

struct StateButton_Previews: PreviewProvider {
    static var previews: some View {
        let subject = CurrentValueSubject<Bool, Never>(false)
        let isValid: AnyPublisher<Bool, Never> = subject.eraseToAnyPublisher()
        StateButton(action: {}, title: "Button", isValid: isValid)
    }
}
