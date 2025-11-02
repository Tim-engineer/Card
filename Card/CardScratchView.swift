//
//  CardScratchView.swift
//  Card
//
//  Created by Tim on 01/11/2025.
//

import SwiftUI

struct CardScratchView: View {
    @Bindable private var m = CardManager.shared
    
    var body: some View {
        ScrollView {
            CardView()
                .overlay {
                    if m.cardState != .scratched {
                        Button {
                            Task {
                                m.uuid = ""
                                await m.generateUUID()
                            }
                        } label: {
                            RoundedRectangle(cornerRadius: 32)
                                .fill(.clear)
                                .overlay {
                                    Group {
                                        if !m.isGenerating {
                                            Label("Scratch", systemImage: "pencil.and.scribble")
                                        } else {
                                            Label("Scratching...", systemImage: "pencil.and.scribble")
                                        }
                                    }
                                    .fontWeight(.bold)
                                }
                        }
                        .buttonStyle(.glass)
                        .buttonBorderShape(.roundedRectangle(radius: 32))
                    }
                }
                .animation(.easeInOut, value: m.cardState)
                .padding()
        }
        .navigationTitle("Card scratching")
        .safeAreaInset(edge: .bottom) {
            Group {
                if m.cardState != .scratched {
                    Button {
                        Task {
                            m.uuid = ""
                            await m.generateUUID()
                        }
                    } label: {
                        Group {
                            if !m.isGenerating {
                                Label("Scratch", systemImage: "pencil.and.scribble")
                            } else {
                                Label("Scratching...", systemImage: "pencil.and.scribble")
                            }
                        }
                        .infinityGlassButton()
                    }
                } else {
                    Button {
                        CardManager.shared.path.removeLast()
                    } label: {
                        Label("Back", systemImage: "chevron.left")
                            .infinityGlassButton()
                    }
                }
            }
            .padding()
        }
        .onDisappear {
            m.isGenerating = false
        }
    }
}

#Preview {
    NavigationStack {
        CardScratchView()
    }
}

//struct CardScratchView: View {
//    @Bindable private var m = CardManager.shared
//    
//    @State private var currentLine = Line()
//    @State private var lines = [Line]()
//    
//    private var isScratched: Bool {
//        lines.flatMap(\.points).count >= 10000
//    }
//    
//    
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 16) {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 32)
//                        .fill(.primary.opacity(0.1))
//                        .frame(height: 256)
//                        .overlay {
//                            Text("Scratch me")
//                                .fontWeight(.heavy)
//                                .font(.title)
//                        }
//                        .overlay(alignment: .bottomTrailing) {
//                            Text("CODE")
//                                .fontWeight(.heavy)
//                                .padding(26)
//                        }
//                    
//                    CardGradient()
//                        .overlay(alignment: .bottomTrailing) {
//                            Text(m.uuid)
//                                .font(.caption)
//                                .fontWeight(.heavy)
//                                .padding(26)
//                        }
//                        .frame(height: 256)
//                        .mask(
//                            Canvas { context, _ in
//                                for line in lines {
//                                    var path = Path()
//                                    path.addLines(line.points)
//                                    context.stroke(path, with: .color(.white), style: StrokeStyle(lineWidth: line.lineWidth, lineCap: .round, lineJoin: .round)
//                                    )
//                                }
//                            }
//                        )
//                        .gesture(
//                            DragGesture(minimumDistance: 0, coordinateSpace: .local)
//                                .onChanged { value in
//                                    let newPoint = value.location
//                                    currentLine.points.append(newPoint)
//                                    lines.append(currentLine)
//                                }
//                        )
//                    
//                }
//                
//                if isScratched {
//                    Text("The card is scratched!")
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("Card")
//    }
//}
//
//struct Line: Hashable {
//    var points = [CGPoint]()
//    var lineWidth: Double = 200
//}
