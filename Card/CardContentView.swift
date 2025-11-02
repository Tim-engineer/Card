//
//  CardContentView.swift
//  Card
//
//  Created by Tim on 02/11/2025.
//

import SwiftUI

struct CardContentView: View {
    @Bindable private var m = CardManager.shared
    
    var body: some View {
        NavigationStack(path: $m.path) {
            ScrollView {
                CardView()
                    .padding()
            }
            .navigationTitle("Card")
            .safeAreaInset(edge: .bottom) {
                HStack(spacing: 16) {
                    Button {
                        m.path.append(CardDestination.scratch)
                    } label: {
                        Label("Scratch", systemImage: "pencil.and.scribble")
                            .infinityGlassButton()
                    }
                    
                    Button {
                        m.path.append(CardDestination.activation)
                    } label: {
                        Label("Activate", systemImage: "aqi.medium")
                            .infinityGlassButton()
                    }
                }
                .padding()
            }
            .navigationDestination(for: CardDestination.self) { item in
                item.destination
            }
            .toolbar {
                // just so you can retry (optional)
                Button("Retry", systemImage: "arrow.clockwise") {
                    m.clear()
                }
            }
        }
    }
}

#Preview {
    CardContentView()
}
