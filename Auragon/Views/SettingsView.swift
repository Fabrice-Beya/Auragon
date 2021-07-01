//
//  Settings.swift
//  Auragon
//
//  Created by Fabrice Beya on 2021/07/01.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authentication: Authentication
    @Binding var isShowingSettingsView: Bool;
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                Button(action: {authentication.updatedAthentication(success: false)}, label: {
                    Text("Logout")
                })
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        isShowingSettingsView.toggle()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019608, green: 0.7019607843, blue: 0.9725490196, alpha: 1)))
                    })
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isShowingSettingsView : .constant(true))
    }
}
