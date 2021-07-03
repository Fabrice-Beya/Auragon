//
//  HomeView.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import SwiftUI

struct HomeView: View {
    @State var showSettingsView = false
    
    var body: some View {
        
        NavigationView{
            ZStack {
                Color.backgroundColor.ignoresSafeArea()
                
                VStack{
                    Text("Weldome Home")
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            showSettingsView.toggle()
                        }, label: {
                            Image(systemName: "gear")
                                .font(.title)
                                .foregroundColor(.textDarkColor)
                        })
                        .fullScreenCover(isPresented: $showSettingsView, content: {
                            SettingsView(showSettingsView: $showSettingsView)
                        })
                    }
            }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
