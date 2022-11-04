//
//  TextFieldView.swift
//  swiftui-base
//
//  Created by Leandro Higa on 31/08/2022.
//

import SwiftUI

struct TextFieldView: View {
    
    @Binding var fieldConfiguration: TextFieldViewConfiguration
    @State var shouldShowError = false
    @State var isEmpty = false
    @State private var isSecuredField: Bool = true
    
    var body: some View {
        VStack {
            VStack {
                Text(fieldConfiguration.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.headline.weight(.regular))
                    .foregroundColor(.black)
                    .opacity(
                        isEmpty
                        ? UI.TextFieldView.textOpacityEmpty
                        : UI.TextFieldView.textOpacityNotEmpty
                    )
                
                if isSecuredField && fieldConfiguration.isSecure {
                    ZStack(alignment: .trailing) {
                        SecureField(fieldConfiguration.placeholder, text: $fieldConfiguration.value)
                            .withStyle(.primary)
                            .accessibility(identifier: "\(fieldConfiguration.title.withNoSpaces)TextField")
                            .padding()
                            .padding(.trailing, fieldConfiguration.isSecure ? UI.TextFieldView.trailingPadding : .zero)
                            .overlay(
                                RoundedRectangle(cornerRadius: UI.Defaults.cornerRadius)
                                    .stroke(Color.black)
                            )
                        Button {
                            isSecuredField = false
                        } label: {
                            Image(systemName: "eye.fill")
                                .padding(.trailing, UI.TextFieldView.imagePadding)
                                .accentColor(.black)
                        }
                    }
                    .frame(maxHeight: UI.TextFieldView.textContainerHeight)
                } else {
                    ZStack(alignment: .trailing) {
                        TextField(fieldConfiguration.placeholder, text: $fieldConfiguration.value)
                            .withStyle(.primary)
                            .accessibility(identifier: "\(fieldConfiguration.title.withNoSpaces)TextField")
                            .padding()
                            .padding(.trailing, fieldConfiguration.isSecure ? UI.TextFieldView.trailingPadding : .zero)
                            .overlay(
                                RoundedRectangle(cornerRadius: UI.Defaults.cornerRadius)
                                    .stroke(Color.black)
                            )
                        if fieldConfiguration.isSecure {
                            Button {
                                isSecuredField = true
                            } label: {
                                Image(systemName: "eye.slash.fill")
                                    .padding(.trailing, UI.TextFieldView.imagePadding)
                                    .accentColor(.black)
                            }
                        }
                    }
                    .frame(maxHeight: UI.TextFieldView.textContainerHeight)
                }
            }
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: UI.TextFieldView.rectangleHeight)
                .foregroundColor(shouldShowError ? .red : .black)
                .opacity(
                    isEmpty
                    ? UI.TextFieldView.rectangleOpacityEmpty
                    : UI.TextFieldView.rectangleOpacityNotEmpty
                )
            Text(fieldConfiguration.errorMessage)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(CGSize(width: .zero, height: UI.TextFieldView.errorTextOffset))
                .font(.footnote)
                .foregroundColor(.red)
                .opacity(
                    shouldShowError ? UI.TextFieldView.errorTextOpacityError : .zero
                )
                .animation(.easeOut(duration: UI.TextFieldView.textAnimationDuration),
                           value: fieldConfiguration.value)
        }
        .onReceive(fieldConfiguration.shouldShowError) { value in
            shouldShowError = value
        }.onReceive(fieldConfiguration.isEmpty) { value in
            isEmpty = value
        }
    }
}

private extension UI {
    enum TextFieldView {
        static let horizontalPadding: Double = 20
        static let trailingPadding: Double = 20
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
        static let imagePadding: Double = 16
        static let textContainerHeight: Double = 45.0
    }
}

struct TextFieldView_Previews: PreviewProvider {
    
    struct BindingTestHolder: View {
        @State var fieldConfiguration = TextFieldViewConfiguration(
            title: "Email",
            placeholder: "Placeholder",
            value: "test@test",
            validations: [.email, .nonEmpty],
            errorMessage: "sign_in_email_textfield_error".localized
        )
        
        var body: some View {
            TextFieldView(fieldConfiguration: $fieldConfiguration)
        }
    }
    
    static var previews: some View {
        BindingTestHolder()
    }
}
