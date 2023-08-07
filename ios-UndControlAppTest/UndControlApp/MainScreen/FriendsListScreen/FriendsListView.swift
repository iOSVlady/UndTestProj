//
//  FriendsListView.swift
//  UndControlApp
//
//  Created by Vladyslav Romaniv on 06.08.2023.
//


import SwiftUI

struct FriendsListView: View {
    @State var showAvailablePeopleList = false
    @EnvironmentObject var friendsManager: FriendsManager
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    UndText(family: .jost, style: .bold, size: 32, "Friends")
                        .foregroundColor(.customColor7)
                        .padding(.leading, 20)

                    Spacer()

                    Button(action: {
                        showAvailablePeopleList = true
                    }) {
                        Image("add-icon")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(5)
                    }
                    .padding(.trailing, 5)
                }
                VStack {
                    FriendsListViewControllerRepresentable(friendsManager: friendsManager)
                }
            }
            .navigationBarHidden(true)
            .background(BackgroundAnimation())
            .fullScreenCover(isPresented: $showAvailablePeopleList) {
                VStack {
                    HStack {
                        UndText(family: .jost, style: .bold, size: 28, "Add new friends")
                            .foregroundColor(.customColor7)
                            .padding(.leading, 20)
                            .padding(.vertical, 8)

                        Spacer()

                        Button(action: {
                            showAvailablePeopleList = false
                        }) {
                            Image("arrow-down")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(5)
                        }
                        .padding(.trailing, 5)
                    }
                    
                    AddFriendsViewControllerRepresentable(friendsManager: friendsManager)
                }
            }
        }
    }
}


