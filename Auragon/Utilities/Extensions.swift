//
//  ParagonExtensions.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import UIKit
import SwiftUI

extension Color {
    static let backgroundColor = Color("backgroundColor")
    static let darkAccent = Color("darkAccent")
}

extension UIApplication {
    func dismissKeyboard(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
