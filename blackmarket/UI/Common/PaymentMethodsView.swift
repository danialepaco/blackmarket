//
//  PaymentMethodsView.swift
//  blackmarket
//
//  Created by Daniel Parra on 12/6/22.
//

import SwiftUI

struct PaymentMethodsView: View {
    var body: some View {
        VStack(spacing: UI.PaymentMethodsView.VStack.spacing) {
            Text("Payment methods")
                .bold()
                .font(.headline)
            HStack(spacing: UI.PaymentMethodsView.HStack.spacing) {
                VStack {
                    Image("cardIcon")
                    Text(LocalizedString.PaymentMethodsScreen.paymentMethodsCreditTitle)
                }
                Divider()
                    .frame(
                        width: UI.PaymentMethodsView.Divider.width,
                        height: UI.PaymentMethodsView.Divider.height
                    )
                    .overlay(.black)
                VStack {
                    Image("paypalIcon")
                    Text(LocalizedString.PaymentMethodsScreen.paymentMethodsPaypalTitle)
                }
                Divider()
                    .frame(
                        width: UI.PaymentMethodsView.Divider.width,
                        height: UI.PaymentMethodsView.Divider.height
                    )
                    .overlay(.black)
                VStack {
                    Image("cryptoIcon")
                    Text(LocalizedString.PaymentMethodsScreen.paymentMethodsCryptoTitle)
                }
            }
            .padding(.horizontal, 50)
        }
        .frame(height: UI.PaymentMethodsView.height)
    }
}

private extension UI {
    enum PaymentMethodsView {
        static let height: CGFloat = 205.0
        
        enum VStack {
            static let spacing: CGFloat = 50.0
        }
        
        enum HStack {
            static let spacing: CGFloat = 30.0
        }
        
        enum Divider {
            static let height: CGFloat = 65.0
            static let width: CGFloat = 1.0
        }
    }
}

private extension LocalizedString {
    enum PaymentMethodsScreen {
        static let paymentMethodsCreditTitle = "payment_methods_credit_title".localized
        static let paymentMethodsPaypalTitle = "payment_methods_paypal_title".localized
        static let paymentMethodsCryptoTitle = "payment_methods_crypto_title".localized
    }
}

struct PaymentMethodsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethodsView()
    }
}
