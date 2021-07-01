//
//  AuthService.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import Foundation

class AuthService {
    static let shared = AuthService()
    
    func login(credentials: Credentials, completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if credentials.password == "password" {
                completion(.success(true))
            } else {
                completion(.failure(.invalidCredentials))
            }
        }
    }
    
    func register(newUser: NewUser, completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if !newUser.username.isEmpty {
                completion(.success(true))
            } else {
                completion(.failure(.invalidRegistration))
            }
        }
    }
    
    func resetPassword(email: String, completion: @escaping (Result<Bool, Authentication.AuthenticationError>) -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if !email.isEmpty {
                completion(.success(true))
            } else {
                completion(.failure(.invalidEmail))
            }
        }
    }
}
