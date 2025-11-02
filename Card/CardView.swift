//
//  CardView.swift
//  Card
//
//  Created by Tim on 02/11/2025.
//

import SwiftUI

struct CardView: View {
    @Bindable private var m = CardManager.shared
    
    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                .init(x: 0.5, y: 1),
                .init(x: 0.5, y: 1),
                .init(x: 0, y: 0),
                
                    .init(x: 0.5, y: 0.5),
                .init(x: 0.5, y: 0.5),
                .init(x: 1, y: 0.5),
                
                    .init(x: 0, y: 0.5),
                .init(x: 0.5, y: 1),
                .init(x: 1, y: 1)
            ],
            colors: [
                .clear,
                .purple.opacity(0.1),
                .clear,
                
                    .purple.opacity(0.4),
                .purple.opacity(0.8),
                .purple.opacity(0.4),
                
                    .clear,
                .clear.opacity(0.4),
                .clear
            ]
        )
        .ignoresSafeArea()
        .glassEffect(.regular.tint(.blue), in: RoundedRectangle(cornerRadius: 32))
        .frame(height: 256)
        .overlay(alignment: .topTrailing) {
            Text(m.cardState.rawValue)
                .foregroundStyle(m.cardState.color)
                .font(.caption)
                .fontWeight(.bold)
                .padding(26)
        }
        .overlay(alignment: .bottom) {
            if m.cardState != .unscratched {
                Text(m.uuid)
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(26)
            }
        }
    }
}
