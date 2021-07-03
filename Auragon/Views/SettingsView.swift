//
//  Settings.swift
//  Auragon
//
//  Created by Fabrice Beya on 2021/07/01.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authentication: Authentication
    @Binding var showSettingsView: Bool;
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.backgroundColor.ignoresSafeArea()
                
                VStack{
                    Spacer()
                    Button(action: {authentication.updatedAthentication(success: false)}, label: {
                        Text("Logout")
                            .foregroundColor(.accentColor)
                    })
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            showSettingsView.toggle()
                        }, label: {
                            Text("Cancel")
                                .foregroundColor(.accentColor)
                        })
                    }
            }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettingsView : .constant(true))
    }
}
