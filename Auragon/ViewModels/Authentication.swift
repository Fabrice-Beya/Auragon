//
//  Authentication.swift
//  Auragon
//
//  Created by Fabrice Beya on 2021/07/01.
//

import SwiftUI

class Authentication: ObservableObject {
    static let shared = Authentication()
    @Published var isAuthenticated: Bool = false
    
    enum AuthenticationError: Error, LocalizedError, Identifiable {
        case invalidCredentials
        case invalidRegistration
        case invalidEmail
        
        var id: String {
            self.localizedDescription
        }
        
        var errorDescription: String?{
            switch self {
            case .invalidCredentials:
                return NSLocalizedString("Email and password are incorrect. Please try again.", comment: "")
            case .invalidRegistration:
                return NSLocalizedString("Your registration details are incorrect. Please try again.", comment: "")
            case .invalidEmail:
                return NSLocalizedString("The email entered is not valid. Please try again.", comment: "")
            }
        }
    }
    
    func updatedAthentication(success: Bool) {
        withAnimation {
            isAuthenticated = success
        }
    }
}
