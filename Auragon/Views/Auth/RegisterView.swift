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
    @Binding var isShowingRegister: Bool;
    
    var body: some View {
        ZStack {
            NavigationView{
//                ScrollView {
                    VStack(spacing: 20){
                        TextField("Username", text: $viewModel.newUser.username)
                            .keyboardType(.default)
                            .modifier(TextFieldStyle())
                        
                        TextField("Email", text: $viewModel.newUser.credentials.email)
                            .keyboardType(.emailAddress)
                            .modifier(TextFieldStyle())
                        
                        SecureField("Password", text: $viewModel.newUser.credentials.password)
                            .modifier(TextFieldStyle())
                        
                        
                        Button(action: {viewModel.register{ success in
                            authentication.updatedAthentication(success: success)
                        }}, label: {
                            Text("Register")
                                .modifier(ButtonStyle(isAccent: false))
                        })
                        .opacity(viewModel.registrationIsDisabled ? 0.6 : 1 )
                        .disabled(viewModel.registrationIsDisabled  ? true : false )
                        
                        Spacer()
                    }
//                }
                .navigationBarItems(trailing:
                                        Button(action: {
                                            isShowingRegister.toggle()
                                        }, label: {
                                            Text("Cancel")
                                                .foregroundColor(Color(#colorLiteral(red: 0.2549019608, green: 0.7019607843, blue: 0.9725490196, alpha: 1)))
                                    }))
                .opacity(viewModel.isBusy ? 0.6 : 1 )
                .onTapGesture {
                    UIApplication.shared.dismissKeyboard()
                }
                .alert(item: $viewModel.error){ error in
                    Alert(title: Text("Invalid Registration"), message: Text(error.localizedDescription))
                }
            }
            
            if viewModel.isBusy {
                ProgressView()
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(isShowingRegister: .constant(true))
    }
}
