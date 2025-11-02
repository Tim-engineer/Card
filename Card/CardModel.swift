//
//  CardModel.swift
//  Card
//
//  Created by Tim on 01/11/2025.
//

import SwiftUI

enum CardDestination: String, Hashable {
    case scratch = "Scratch"
    case activation = "Activation"
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .scratch:
            CardScratchView()
        case .activation:
            CardActivationView()
        }
    }
}

enum CardState: String, Hashable {
    case unscratched = "Unscratched"
    case scratched = "Scratched"
    case activated = "Activated"
    
    var color: Color {
        switch self {
        case .unscratched:
                .primary
        case .scratched:
                .orange
        case .activated:
                .green
        }
    }
}

struct CardActivationDecodable: Decodable {
    let ios: String
}
