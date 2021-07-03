//
//  AuragonButton.swift
//  Auragon
//
//  Created by Fabrice Beya on 2021/07/03.
//

import SwiftUI

struct AuragonButton: View {
    let title: String
    let buttonConfig: ButtonConfig
    
    var body: some View {
        switch buttonConfig{
            case .largeDark:
                Text(title)
                    .foregroundColor(.textColor)
                    .font(.headline)
                    .padding()
                    .frame(width: formItemWidth, height: formItemHeight)
                    .background(Color.accentColor)
                    .clipShape(Capsule())
            case .largeLight:
                Text(title)
                    .foregroundColor(.accentTextColor)
                    .font(.headline)
                    .padding()
                    .frame(width: formItemWidth, height: formItemHeight)
                    .background(Color.white)
                    .clipShape(Capsule())
        }
    }
}

struct AuragonButton_Previews: PreviewProvider {
    static var previews: some View {
        AuragonButton(title: "Title", buttonConfig: .largeDark)
//            .preferredColorScheme(.dark)
    }
}

enum ButtonConfig {
    case largeDark
    case largeLight
}
