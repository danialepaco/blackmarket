//
//  TabBarIcon.swift
//  blackmarket
//
//  Created by Daniel Parra on 12/6/22.
//

import SwiftUI

struct TabBarIcon: View {
    
    @StateObject var viewRouter: ViewRouter
    let assignedPage: TabPage
    
    let width: CGFloat
    let height: CGFloat
    let imageName: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Spacer()
        }
        .padding(.horizontal, -4)
        .onTapGesture {
            viewRouter.currentPage = assignedPage
        }
        .foregroundColor(viewRouter.currentPage == assignedPage ? .white : .gray)
    }
}
