//
//  RegisterView.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authentication: Authentication
    @StateObject var viewModel = RegisterViewModel()
    @Binding var isShowingRegister: Bool
    @State var passwordTapped = false
    
    var body: some View {
        NavigationView {
            ZStack{
                Color.backgroundColor.ignoresSafeArea()
                    VStack(spacing: 20){
                        VStack{
                            if viewModel.invalidUsername {
                                HStack{
                                    Text("Username is invalid")
                                        .font(.caption)
                                        .foregroundColor(.red)
                                    Spacer()
                                }
                                .padding(.horizontal, 40)
                            }
                            
                            TextField("Username", text: $viewModel.newUser.username, onEditingChanged: { (editingChanged) in
                                if !editingChanged {
                                    viewModel.validateUsername()
                                }
                            })
                                .keyboardType(.default)
                                .modifier(TextFieldStyle(inValidInput: viewModel.invalidUsername))
                        }
                        
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
                            TextField("Email", text: $viewModel.newUser.credentials.email, onEditingChanged: { (editingChanged) in
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
                            SecureField("Password", text: $viewModel.newUser.credentials.password)
                                .modifier(TextFieldStyle(inValidInput: viewModel.invalidPassword))
                                .onTapGesture {
                                    passwordTapped.toggle()
                                }
                        }
                        
                        Button(action: {viewModel.register{ success in
                            authentication.updatedAthentication(success: success)
                        }}, label: {
                            AuragonButton(title: "Register", buttonConfig: .largeDark)
                        })
                        .opacity(viewModel.registrationIsDisabled ? 0.6 : 1 )
                        .disabled(viewModel.registrationIsDisabled  ? true : false )
                        
                        Spacer()
                    }
                    .onTapGesture {
                        UIApplication.shared.dismissKeyboard()
                        if passwordTapped {
                            viewModel.validatePassword()
                        }
                    }
                .navigationBarItems(trailing:
                                        Button(action: {
                                            isShowingRegister.toggle()
                                        }, label: {
                                            Text("Cancel")
                                                .foregroundColor(.accentColor)
                                    }))
                
                
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
        }
        .opacity(viewModel.isBusy ? 0.6 : 1 )
        .alert(item: $viewModel.error){ error in
            Alert(title: Text("Invalid Registration"), message: Text(error.localizedDescription))
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(isShowingRegister: .constant(true))
    }
}
