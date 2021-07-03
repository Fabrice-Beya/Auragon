//
//  TextFieldStyle.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import SwiftUI

struct TextFieldStyle: ViewModifier {
    let inValidInput: Bool
    
    func body(content: Content) -> some View {
        content
            .padding()
            .padding(.horizontal, 8)
            .background(Color.shadowColor)
            .clipShape(Capsule())
            .shadow(color: inValidInput ? Color.red.opacity(0.08) : Color.black.opacity(0.08), radius: 5, x: 1, y: 1)
            .shadow(color: inValidInput ? Color.red.opacity(0.08) : Color.black.opacity(0.08), radius: 5, x: -1, y: -1)
            .frame(width: formItemWidth, height: formItemHeight)
            .autocapitalization(.none)
    }
}

struct TextFieldStyle_Previewer: PreviewProvider {
    static var previews: some View {
        VStack{
            HStack{
                Text("Email is invalid")
                    .font(.caption)
                    .foregroundColor(.red)
                Spacer()
            }
            .padding(.bottom, 4)
            .padding(.horizontal, 40)
            TextField("Email", text: .constant(""))
                .modifier(TextFieldStyle(inValidInput: true))
    //            .preferredColorScheme(.dark)
        }
    }
}
