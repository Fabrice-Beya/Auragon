//
//  PasswordResetViewModel.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import Foundation

class PasswordResetViewModel: ObservableObject {
    @Published var email = ""
    @Published var isBusy = false
    @Published var error: Authentication.AuthenticationError?
    
    @Published var invalidEmail = false
    func validateEmail() {
        if email.isEmpty || !email.isEmail(){
            invalidEmail = true
        } else {
            invalidEmail = false
        }
    }
    
    var resetInvalid: Bool {
        email.isEmpty || !email.isEmail()
    }
    
    func resetPassword(complection: @escaping (Bool) -> Void){
        isBusy = true
        AuthService.shared.resetPassword(email: email) { [unowned self](result: Result<Bool, Authentication.AuthenticationError>) in
            isBusy = false
            switch result{
            case .success:
                complection(true)
            case .failure(let authError):
                error = authError
                complection(false)
            }
        }
    }
}

