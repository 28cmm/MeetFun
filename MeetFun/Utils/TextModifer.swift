//
//  TextModifer.swift
//  MeetFun
//
//  Created by Yilei Huang on 2020-12-07.
//

import SwiftUI

extension View{
    func normalText() -> some View{
        modifier(TextModifer())
    }
    
    func normalShadow() -> some View{
        modifier(ShadowModifer())
    }
}

struct NavigationLazyView<T: View>: View {
    let build: () -> T
    init(_ build: @autoclosure @escaping () -> T) {
        self.build = build
    }
    var body: T {
        build()
    }
}

extension Image{
    func normalImage() -> some View{
        self
            .resizable()
            .scaledToFill()
            .clipShape(Circle())
    }
}

extension View{
    func flippedUpsideDown() -> some View{
        self.modifier(FlippedUpsideDown())
    }
}

struct FlippedUpsideDown: ViewModifier {
    func body(content: Content) -> some View {
        content
            .rotationEffect(.init(degrees: .pi))
            .scaleEffect(x: -1, y: 1, anchor: .center)
    }
}


struct TextModifer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15, weight: .semibold))
            .multilineTextAlignment(.center)
            .foregroundColor(Color(NAVBACKGROUNDCOLOR))
    }
}

struct ShadowModifer:ViewModifier {
    func body(content: Content) -> some View {
        content
            //.padding(.horizontal,25)
            // .padding(.vertical,5)
            //        .background(Color.white)
            //        .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
        
    }
}


extension Color {
    static let discoverBackground = Color(.init(white:0.95, alpha: 1))
}




