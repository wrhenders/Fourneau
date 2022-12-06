//
//  SnapCarousel.swift
//  Fourneau
//
//  Created by Ryan Henderson on 12/1/22.
//

import SwiftUI

struct SnapCarousel<Content: View>: View {
    var content: Content
    var length: Int
    
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    
    init(spacing: CGFloat = 20, trailingSpace: CGFloat = 60, index: Binding<Int>, length: Int, @ViewBuilder content: @escaping ()-> Content) {
        self.length = length
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
            .offset(x: (CGFloat(index) * -width) + (index != 0 ? adjustmentWidth : 0) + offset )
            .gesture(
                DragGesture()
                    .updating($offset, body: {value, out, _ in
                        out = value.translation.width
                    })
                    .onChanged({value in
                        let offsetX = value.translation.width
                        // convert translation into progress (0-1)
                        let progress = -offsetX / width
                        let roundIndex = progress.rounded()
                        currentIndex = max(min(index + Int(roundIndex), length - 1), 0)
                    })
                    .onEnded({ _ in
                        index = currentIndex
                    })
            )
            .animation(.easeInOut, value: index)
        }
    }
}

//struct SnapCarousel_Previews: PreviewProvider {
//    static var previews: some View {
//        BakingMethodView()
//    }
//}
