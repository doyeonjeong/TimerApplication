//
//  UserMainView.swift
//  TimerForStudy
//
//  Created by Doyeon on 2023/01/10.
//

import SwiftUI

struct UserMainView: View {
    var body: some View {
        NavigationView {
            List {
                ZStack {
                    NavigationLink(destination: UserDetailView()) {
                        EmptyView()
                    }
                    .opacity(0.0)
                    .buttonStyle(PlainButtonStyle())
                    
                    MyProfileRow()
                }
                
                Section {
                    // Followers
                    FollowersRow(followerImage: "User1", nickname: "닉네임1", statusMessage: "상태메세지1", Dday: "D-14")
                    FollowersRow(followerImage: "User2", nickname: "닉네임2", statusMessage: "상태메세지2", Dday: "D-30")
                    FollowersRow(followerImage: "User3", nickname: "닉네임3", statusMessage: "상태메세지3", Dday: "D-50")
                    FollowersRow(followerImage: "User4", nickname: "닉네임4", statusMessage: "상태메세지4", Dday: "D-100")
                    
                } header: {
                    Text("Followers")
                        .textCase(nil)
                        .font(.title)
                        .bold()
                        .padding(.leading, -16)
                        .foregroundColor(.black)
                }
            }//: List
        }//: NavigationView
    }
}

struct UserMainView_Previews: PreviewProvider {
    static var previews: some View {
        UserMainView()
    }
}
