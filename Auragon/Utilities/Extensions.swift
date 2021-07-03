//
//  ParagonExtensions.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import UIKit
import SwiftUI

extension Color {
    // Background colors
    static let backgroundColor = Color("backgroundColor")
    static let aceentBackgroundColor = Color("aceentBackgroundColor")
    
    // Text Colors
    static let accentTextColor = Color("accentTextColor")
    static let textColor = Color("textColor")
    static let textDarkColor = Color("textDarkColor")
    
    // Shadow Colors
    static let shadowColor = Color("shadowColor")
    
}

extension UIApplication {
    func dismissKeyboard(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

let __firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
let __serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
let __emailRegex = __firstpart + "@" + __serverpart + "[A-Za-z]{2,8}"
let __emailPredicate = NSPredicate(format: "SELF MATCHES %@", __emailRegex)

extension String {
    func isEmail() -> Bool {
        return __emailPredicate.evaluate(with: self)
    }
}
