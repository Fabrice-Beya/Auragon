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
    @Binding var isShowingLogin: Bool;
    
    var body: some View {
        ZStack {
            NavigationView{
                VStack(spacing: 20){
                    TextField("Email", text: $viewModel.credentials.email)
                        .keyboardType(.emailAddress)
                        .modifier(TextFieldStyle())
                    
                    SecureField("Password", text: $viewModel.credentials.password)
                        .modifier(TextFieldStyle())
                    
                    Button(action: {viewModel.login{ success in
                        authentication.updatedAthentication(success: success)
                    }}, label: {
                        Text("Login")
                            .modifier(ButtonStyle(isAccent: false))
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
                                                .foregroundColor(Color(#colorLiteral(red: 0.2549019608, green: 0.7019607843, blue: 0.9725490196, alpha: 1)))
                                        }))
                .opacity(viewModel.isBusy ? 0.6 : 1 )
            }
            if viewModel.isBusy {
                ProgressView()
            }
        }
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
        .alert(item: $viewModel.error){ error in
            Alert(title: Text("Invalid Login"), message: Text(error.localizedDescription))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isShowingLogin: .constant(true))
    }
}
