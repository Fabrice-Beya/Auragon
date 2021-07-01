//
//  ParagonApp.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import SwiftUI

@main
struct AuragonApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Authentication.shared)
        }
    }
}
