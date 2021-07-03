//
//  ButtonStyle.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import SwiftUI

struct ButtonStyle: ViewModifier {
    @State var isAccent: Bool
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.accentColor)
            .padding()
            .frame(width: formItemWidth, height: formItemHeight)
            .background(isAccent ? Color.white : Color.accentColor)
            .clipShape(Capsule())
    }
}

struct ButtonStyle_Previewer: PreviewProvider {
    static var previews: some View {
        Text("Button Title")
            .modifier(ButtonStyle(isAccent: false))
    }
}

