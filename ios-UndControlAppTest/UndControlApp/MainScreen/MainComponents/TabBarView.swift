//
//  TabBarView.swift
//  UndControlApp
//
//  Created by Vladyslav Romaniv on 02.07.2023.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var friendsManager = FriendsManager()
    @State var selectedTab = "friends"

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab) {
                FriendsListView()
                    .environmentObject(friendsManager)
                    .tag("friends")
            }

            HStack(spacing: 0) {
                Spacer()
                ForEach(tabs, id: \.self) { image in
                    TabButton(image: image, selectedTab: $selectedTab)

                    if image != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 35)
            .padding(.top, 10)
            .background(Color.customColor7)
            .background(Color.customColor7.shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: -5))
            .cornerRadius(20)
        }
        .ignoresSafeArea()
    }
    
    var tabs = ["friends"]
}


struct TabButton: View {
    var image: String
    @Binding var selectedTab: String
    var body: some View {
        Button(action: {
            selectedTab = image
        }) {
            VStack {
                Image(image)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 28, height: 28)
                    .foregroundColor(selectedTab == image ? Color.customColor1 : Color.customColor6)
                    .font(.title2)
                    
                

            }.padding(.horizontal, 20)
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
