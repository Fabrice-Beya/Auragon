//
//  LoginViewModel.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var credentials = Credentials()
    @Published var isBusy = false
    @Published var error: Authentication.AuthenticationError?
    
    @Published var invalidEmail = false
    func validateEmail() {
        if credentials.email.isEmpty || !credentials.email.isEmail(){
            invalidEmail = true
        } else {
            invalidEmail = false
        }
    }
    
    @Published var invalidPassword = false
    func validatePassword(){
        if  credentials.password.isEmpty || credentials.password.count<7 {
            invalidPassword = true
        } else {
            invalidPassword = false
        }
    }
    
    var loginDisabled: Bool {
       return credentials.email.isEmpty || !credentials.email.isEmail() || credentials.password.isEmpty || credentials.password.count<7
    }
    
    func login(complection: @escaping (Bool) -> Void){
        isBusy = true
        AuthService.shared.login(credentials: credentials) { [unowned self](result: Result<Bool, Authentication.AuthenticationError>) in
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
