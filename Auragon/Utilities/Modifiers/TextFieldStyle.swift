//
//  TextFieldStyle.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import SwiftUI

struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .padding(.horizontal, 8)
            .background(Color.darkAccent)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 1, y: 1)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: -1, y: -1)
            .frame(width: formItemWidth, height: formItemHeight)
            .autocapitalization(.none)
    }
}

struct TextFieldStyle_Previewer: PreviewProvider {
    static var previews: some View {
        TextField("Email", text: .constant(""))
            .modifier(TextFieldStyle())
    }
}
