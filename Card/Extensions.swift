//
//  Extensions.swift
//  Card
//
//  Created by Tim on 02/11/2025.
//

import SwiftUI

extension View {
    func infinityGlassButton() -> some View {
        self.padding()
            .frame(maxWidth: .infinity)
            .glassEffect()
    }
}
