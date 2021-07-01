//
//  PasswordResetView.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import SwiftUI

struct PasswordResetView: View {
    @StateObject var viewModel = PasswordResetViewModel()
    @Binding var showPasswordReset: Bool
    @State private var showSuccessAlert = false
    
    var body: some View {
        ZStack {
            NavigationView{
                VStack(spacing: 20){
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .modifier(TextFieldStyle())
                    
                    Button(action: {viewModel.resetPassword{ success in
                        if success {
                            showSuccessAlert = true
                        }
                    }}, label: {
                        Text("Submit")
                            .modifier(ButtonStyle(isAccent: false))
                    })
                    .opacity(viewModel.resetInvalid ? 0.6 : 1 )
                    .disabled(viewModel.resetInvalid  ? true : false )
                    
                    Spacer()
                }
                .navigationBarItems(trailing:
                                        Button(action: {
                                            showPasswordReset.toggle()
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
            Alert(title: Text("Error"), message: Text(error.localizedDescription))
        }
        .alert(isPresented: $showSuccessAlert) {
            Alert(title: Text("Reset Successfull"),
            message: Text("A password reset has been sent to your email."),
            dismissButton: .default(Text("Ok")){
                showPasswordReset = false
            })
        }
        
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetView(showPasswordReset: .constant(true))
    }
}
