//
//  RegisterViewModel.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var newUser = NewUser()
    @Published var isBusy = false
    @Published var error: Authentication.AuthenticationError?
    
    @Published var invalidUsername = false
    func validateUsername() {
        if newUser.username.isEmpty{
            invalidUsername = true
        } else {
            invalidUsername = false
        }
    }
    
    @Published var invalidEmail = false
    func validateEmail() {
        if newUser.credentials.email.isEmpty || !newUser.credentials.email.isEmail(){
            invalidEmail = true
        } else {
            invalidEmail = false
        }
    }
    
    @Published var invalidPassword = false
    func validatePassword(){
        if  newUser.credentials.password.isEmpty || newUser.credentials.password.count<7 {
            invalidPassword = true
        } else {
            invalidPassword = false
        }
    }
    
    var registrationIsDisabled: Bool {
        newUser.credentials.email.isEmpty ||
        newUser.credentials.password.isEmpty ||
        !newUser.credentials.email.isEmail() ||
        newUser.username.isEmpty
    }
    
    func register(complection: @escaping (Bool) -> Void){
        isBusy = true
        AuthService.shared.register(newUser: newUser) { [unowned self](result: Result<Bool, Authentication.AuthenticationError>) in
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

