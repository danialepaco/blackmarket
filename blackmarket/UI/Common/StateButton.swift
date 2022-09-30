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
                        isEnabled ?
                        .init(hex: "ffffff") :
                        .init(hex: "636363")
                    )
                    .background(
                        isEnabled ?
                        Color.init(hex: "00031A") :
                        Color.init(hex: "E0E0E0")
                    )
            }
            .cornerRadius(8)
            .disabled(!isEnabled)
    }
}

struct StateButton_Previews: PreviewProvider {
    
    @State static var isEnabled: Bool = false
    
    static var previews: some View {
        StateButton(action: {
            
        }, title: "Button", isEnabled: isEnabled)
    }
}
