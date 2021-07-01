//
//  LandingView.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import SwiftUI

struct LandingView: View {
    @State var showRegisterView = false
    @State var showLoginView = false
    
    var body: some View {
        VStack{
            Spacer()
            
            Text("Welcome to Auragon.")
                .font(.system(size: 28, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding()
            
            Button(action:{showRegisterView.toggle()}, label: {
                Text("Create account")
                    .modifier(ButtonStyle(isAccent: true))
            })
            .padding(.horizontal, 32)
            .fullScreenCover(isPresented: $showRegisterView, content: {
                RegisterView(isShowingRegister: $showRegisterView)
            })
            
            Spacer()
            
            Button(action: {showLoginView.toggle()}, label: {
                HStack{
                    Text("Already have an account?")
                        .font(.system(size: 14))
                    
                    Text("Login In Here")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundColor(.white)
                .padding(.bottom, 40)
            })
            .fullScreenCover(isPresented: $showLoginView, content: {
                LoginView(isShowingLogin: $showLoginView)
            })
        }
        .background(Color.accentColor)
        .ignoresSafeArea()
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
