//
//  LoginView.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authentication: Authentication
    @StateObject var viewModel = LoginViewModel()
    @State var showPasswordReset = false
    @State var typing = false
    @Binding var isShowingLogin: Bool;
    @State var passwordTapped = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.backgroundColor.ignoresSafeArea()
                VStack(spacing: 20){
                    VStack{
                        if viewModel.invalidEmail {
                            HStack{
                                Text("Email is invalid")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                Spacer()
                            }
                            .padding(.horizontal, 40)
                        }
                        
                        TextField("Email", text: $viewModel.credentials.email, onEditingChanged: { (editingChanged) in
                            if !editingChanged {
                                viewModel.validateEmail()
                            }
                        })
                            .keyboardType(.emailAddress)
                            .modifier(TextFieldStyle(inValidInput: viewModel.invalidEmail))
                    }
                    
                    VStack{
                        if viewModel.invalidPassword {
                            HStack{
                                Text("Password is invalid")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                Spacer()
                            }
                            .padding(.horizontal, 40)
                        }
                        
                        SecureField("Password", text: $viewModel.credentials.password)
                            .modifier(TextFieldStyle(inValidInput: viewModel.invalidPassword))
                            .onTapGesture {
                                passwordTapped.toggle()
                            }
                    }
                    
                    Button(action: {viewModel.login{ success in
                        authentication.updatedAthentication(success: success)
                    }}, label: {
                        AuragonButton(title: "Login", buttonConfig: .largeDark)
                    })
                    .opacity(viewModel.loginDisabled ? 0.6 : 1 )
                    .disabled(viewModel.loginDisabled  ? true : false )
                    
                    Spacer()
                    
                    Button(action: {showPasswordReset.toggle()}, label: {
                        HStack{
                            Text("Forgot your password?")
                                .font(.system(size: 14))
                            
                            Text("Reset here")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(.accentColor)
                        .padding(.bottom, 40)
                    })
                    .fullScreenCover(isPresented: $showPasswordReset, content: {
                        PasswordResetView(showPasswordReset: $showPasswordReset)
                    })
                }
                .navigationBarItems(trailing:
                                        Button(action: {
                                            isShowingLogin.toggle()
                                        }, label: {
                                            Text("Cancel")
                                                .foregroundColor(.accentColor)
                                        }))
                .opacity(viewModel.isBusy ? 0.6 : 1 )
                .onTapGesture {
                    UIApplication.shared.dismissKeyboard()
                    if passwordTapped {
                        viewModel.validatePassword()
                    }
                }
                
                if viewModel.isBusy {
                    ProgressView()
                }
            }
            .onTapGesture {
                UIApplication.shared.dismissKeyboard()
                if passwordTapped {
                    viewModel.validatePassword()
                }
            }
            .alert(item: $viewModel.error){ error in
                Alert(title: Text("Invalid Login"), message: Text(error.localizedDescription))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isShowingLogin: .constant(true))
    }
}
