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
    
    var loginDisabled: Bool {
        credentials.email.isEmpty || credentials.password.isEmpty
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
