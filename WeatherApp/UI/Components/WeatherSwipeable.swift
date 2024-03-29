//
//  WeatherSwippeable.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 28/01/23.
//

import SwiftUI

struct WeatherSwipeable<Content: View>: View {
    var content: () -> Content
    var itemHeight: CGFloat
    var canDelete: Bool
    var actionRemove: () -> Void
    
    @State var hoffset: CGFloat = 0
    @State var anchor: CGFloat = 0
    @State var rightPast = false
    @State var contentWidth = UIScreen.main.bounds.width
    
    let screenWidth = UIScreen.main.bounds.width
    let anchorWidth: CGFloat = 90
    
    
    init(@ViewBuilder content: @escaping () -> Content,
         itemHeight: CGFloat,
         canDelete: Bool = true,
         actionRemove: @escaping () -> Void
    ) {
        self.content = content
        self.itemHeight = itemHeight
        self.actionRemove = actionRemove
        self.canDelete = canDelete
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation {
                    if canDelete {
                        hoffset = anchor + value.translation.width
                        rightPast = hoffset < -anchorWidth + (screenWidth / 15 )
                    }
                }
            }
            .onEnded { _ in
                withAnimation {
                    if canDelete {
                        anchor = rightPast ? -anchorWidth : .zero
                        hoffset = anchor
                    }
                }
            }
    }
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: .zero) {
                content()
                    .frame(width: rightPast ? proxy.size.width - anchorWidth : proxy.size.width)
                    .zIndex(.zero)
                Button {
                    rightPast = false
                    delay(deadline: 0.5) {
                        actionRemove()
                    }                    
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(WeatherColor.background.color)
                        .font(.system(size: 40))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 20)
                }
                .background(WeatherColor.dangerous.color)
                .cornerRadius(16)
                .frame(width: anchorWidth)
                .zIndex(1)
                .clipped()
            }
        }
        .frame(height: itemHeight)
        .contentShape(Rectangle())
        .gesture(drag)
        .clipped()
        .animation(.default)
    }
}
