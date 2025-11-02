//
//  CardManager.swift
//  Card
//
//  Created by Tim on 01/11/2025.
//

import SwiftUI

@MainActor
@Observable
final class CardManager {
    static let shared = CardManager()
    
    var url = "https://api.o2.sk"
    
    var path = NavigationPath()
    
    var cardState: CardState = .unscratched
    
    var uuid = ""
    
    var isGenerating = false
    
    var isShowingActivationError = false
    
    func generateUUID() async {
        isGenerating = true
        
        try? await Task.sleep(for: .seconds(2))
        
        if isGenerating {
            uuid = UUID().uuidString
            
            cardState = .scratched
        }
        
        isGenerating = false
    }
    
    func activate() async {
        let fullURL = url + "/version?code=\(uuid)"
        
        let request = await API.request(method: .get, url: fullURL)
        
        do {
            let decodedData = try await API.decode(to: CardActivationDecodable.self, for: request)
            if Double(decodedData.ios) ?? 0 > 6.1 {
                cardState = .activated
            } else {
                isShowingActivationError = true
            }
        } catch {
            isShowingActivationError = true
        }
    }
    
    func clear() {
        path.removeLast(path.count)
        cardState = .unscratched
        uuid = ""
        isGenerating = false
        isShowingActivationError = false
    }
}

