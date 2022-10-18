//
//  TextFieldView.swift
//  swiftui-base
//
//  Created by Leandro Higa on 31/08/2022.
//

import SwiftUI

struct TextFieldView: View {
    
    @Binding var fieldConfiguration: TextFieldViewConfiguration
    
    var body: some View {
        VStack {
            VStack {
                Text(fieldConfiguration.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.headline.weight(.regular))
                    .foregroundColor(.black)
                    .opacity(
                        fieldConfiguration.isEmpty
                        ? UI.TextFieldView.textOpacityEmpty
                        : UI.TextFieldView.textOpacityNotEmpty
                    )
                
                if fieldConfiguration.isSecure {
                    SecureField(fieldConfiguration.placeholder, text: $fieldConfiguration.value)
                        .withStyle(.primary)
                        .accessibility(identifier: "\(fieldConfiguration.title.withNoSpaces)TextField")
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black)
                        )
                } else {
                    TextField(fieldConfiguration.placeholder, text: $fieldConfiguration.value)
                        .withStyle(.primary)
                        .accessibility(identifier: "\(fieldConfiguration.title.withNoSpaces)TextField")
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black)
                        )
                }
            }
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: UI.TextFieldView.rectangleHeight)
                .foregroundColor(fieldConfiguration.shouldShowError ? .red : .black)
                .opacity(
                    fieldConfiguration.isEmpty
                    ? UI.TextFieldView.rectangleOpacityEmpty
                    : UI.TextFieldView.rectangleOpacityNotEmpty
                )
            Text(fieldConfiguration.errorMessage)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(CGSize(width: .zero, height: UI.TextFieldView.errorTextOffset))
                .font(.footnote)
                .foregroundColor(.red)
                .opacity(
                    fieldConfiguration.shouldShowError ? UI.TextFieldView.errorTextOpacityError : .zero
                )
                .animation(.easeOut(duration: UI.TextFieldView.textAnimationDuration),
                           value: fieldConfiguration.value)
        }
    }
}

private extension UI {
    enum TextFieldView {
        static let horizontalPadding: Double = 20
        static let rectangleHeight: Double = 1
        static let textOffset: Double = -30
        static let textOpacityEmpty: Double = 0.7
        static let textOpacityNotEmpty: Double = 1
        static let textAnimationDuration: Double = 0.2
        static let textScaleEffectEmpty: Double = 1
        static let textScaleEffectNotEmpty: Double = 0.8
        static let rectangleOpacityEmpty: Double = 0.7
        static let rectangleOpacityNotEmpty: Double = 1
        static let errorTextOffset: Double = -5
        static let errorTextOpacityError: Double = 1
    }
}

struct TextFieldView_Previews: PreviewProvider {
    
    struct BindingTestHolder: View {
        @State var fieldConfiguration = TextFieldViewConfiguration(
            title: "Email",
            placeholder: "Placeholder",
            value: "test@test",
            validations: [.email, .nonEmpty],
            errorMessage: "Please enter a valid email"
        )
        
        var body: some View {
            TextFieldView(fieldConfiguration: $fieldConfiguration)
        }
    }
    
    static var previews: some View {
        BindingTestHolder()
    }
}
