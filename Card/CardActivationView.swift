//
//  CardActivationView.swift
//  Card
//
//  Created by Tim on 01/11/2025.
//

import SwiftUI

struct CardActivationView: View {
    @Bindable private var m = CardManager.shared
    
    var body: some View {
        ScrollView {
            Group {
                if m.cardState != .unscratched {
                    CardView()
                } else {
                    MyEmptyView(symbol: "pencil.and.scribble", text: "The card is not scratched!", buttonSymbol: "pencil.and.scribble", buttonText: "Scratch") {
                        CardManager.shared.path.append(CardDestination.scratch)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Card activation")
        .safeAreaInset(edge: .bottom) {
            if m.cardState == .scratched {
                Button {
                    Task {
                        await m.activate()
                    }
                } label: {
                    Label("Activate", systemImage: "aqi.medium")
                        .infinityGlassButton()
                        .padding()
                }
            } else if m.cardState == .activated {
                Button {
                    CardManager.shared.path.removeLast()
                } label: {
                    Label("Back", systemImage: "chevron.left")
                        .infinityGlassButton()
                        .padding()
                }
            }
        }
        .sheet(isPresented: $m.isShowingActivationError) {
            MyEmptyView(symbol: "aqi.high", text: "Could not activate the card!", paddingTop: 0, buttonSymbol: "arrow.clockwise", buttonText: "Try again") {
                Task {
                    await m.activate()
                }
            }
            .presentationDetents([.medium])
        }
    }
}

#Preview {
    NavigationStack {
        CardActivationView()
    }
}
