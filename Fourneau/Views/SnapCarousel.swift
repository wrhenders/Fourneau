//
//  SnapCarousel.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/1/22.
//

import SwiftUI

struct SnapCarousel<Content: View>: View {
    var content: Content
    var list: [BakingStep]
    
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    
    init(spacing: CGFloat = 20, trailingSpace: CGFloat = 60, index: Binding<Int>, items: [BakingStep], @ViewBuilder content: ()-> Content) {
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content()
    }
    
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
        GeometryReader {proxy in
            
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjustmentWidth = (trailingSpace / 2) - spacing
            
            HStack(spacing:spacing) {
                content
                    .frame(width: proxy.size.width - trailingSpace)
            }
            .padding(.horizontal, spacing)
            .offset(x: (CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjustmentWidth : 0) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: {value, out, _ in
                        out = value.translation.width
                    })
                    .onEnded( {value in
                        let offsetX = value.translation.width
                        // convert translation into progress (0-1)
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        
                        currentIndex = index
                    })
                    .onChanged({value in
                        let offsetX = value.translation.width
                        // convert translation into progress (0-1)
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                    })
            )
        }
        .animation(.easeInOut, value: offset == 0)
    }
}

struct SnapCarousel_Previews: PreviewProvider {
    static var previews: some View {
        BakingStepList()
    }
}
