//
//  HomeView.swift
//  Paragon
//
//  Created by Fabrice Beya on 2021/06/24.
//

import SwiftUI

struct HomeView: View {
    @State var isShowingSettingsView = false
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {isShowingSettingsView.toggle()}, label: {
                    Image(systemName: "gear")
                        .font(.title)
                })
                .buttonStyle(PlainButtonStyle())
                .fullScreenCover(isPresented: $isShowingSettingsView, content: {
                    SettingsView(isShowingSettingsView: $isShowingSettingsView)
                })
            }   
            .padding()
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
