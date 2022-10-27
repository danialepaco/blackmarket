//
//  StateButton.swift
//  blackmarket
//
//  Created by Daniel Parra on 9/28/22.
//

import SwiftUI

struct StateButton: View {
    let action: () -> ()
    let title: String
    var isEnabled: Bool

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
    }
}

struct StateButton_Previews: PreviewProvider {
    
    static var previews: some View {
        StateButton(action: {}, title: "Button", isEnabled: false)
    }
}
