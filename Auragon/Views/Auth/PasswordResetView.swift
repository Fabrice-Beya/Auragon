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
        NavigationView {
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
                        TextField("Email", text: $viewModel.email, onEditingChanged: { (editingChanged) in
                            if !editingChanged {
                                viewModel.validateEmail()
                            }
                        })
                            .keyboardType(.emailAddress)
                            .modifier(TextFieldStyle(inValidInput: viewModel.invalidEmail))
                    }
                    
                    Button(action: {viewModel.resetPassword{ success in
                        if success {
                            showSuccessAlert = true
                        }
                    }}, label: {
                        AuragonButton(title: "Submit", buttonConfig: .largeDark)
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
                                                .foregroundColor(.accentColor)
                                        }))
                .opacity(viewModel.isBusy ? 0.6 : 1 )
                
                if viewModel.isBusy {
                    ProgressView()
                }
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
