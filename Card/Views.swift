//
//  Views.swift
//  Card
//
//  Created by Tim on 02/11/2025.
//

import SwiftUI

struct MyEmptyView: View {
    let symbol: String
    let text: String
    var paddingTop: CGFloat = 128
    let buttonSymbol: String
    let buttonText: String
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: symbol)
                .font(.system(size: 64))
            Text(text)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Button {
                action()
            } label: {
                HStack {
                    Image(systemName: buttonSymbol)
                    Text(buttonText)
                }
                .padding(8)
                .padding(.horizontal, 4)
                .glassEffect()
            }
            .tint(.blue)
        }
        .padding(.top, paddingTop)
    }
}
