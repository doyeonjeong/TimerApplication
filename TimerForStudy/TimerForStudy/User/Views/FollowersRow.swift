//
//  FollowersRow.swift
//  TimerForStudy
//
//  Created by Doyeon on 2023/01/12.
//

import SwiftUI

struct FollowersRow: View {
    var followerImage: String
    var nickname: String
    var statusMessage: String
    var Dday: String
    
    var body: some View {
        HStack {
            Image(followerImage)
                .resizable()
                .clipShape(Circle())
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
            VStack(alignment: .leading, spacing: 15) {
                Text(nickname)
                    .bold()
                    .font(.title3)
                Text(statusMessage)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            Text(Dday)
                .padding(6)
                .background(content: {
                    Color.gray.opacity(0.20)
                })
                .cornerRadius(10)
        }//: HStack
        .frame(height: 80)
        .padding(.leading, -16)
    }
}

struct FollowersRow_Previews: PreviewProvider {
    static var previews: some View {
        FollowersRow(followerImage: "User1", nickname: "닉네임1", statusMessage: "상태메세지1", Dday: "D-14")
        FollowersRow(followerImage: "User2", nickname: "닉네임2", statusMessage: "상태메세지2", Dday: "D-30")
        FollowersRow(followerImage: "User3", nickname: "닉네임3", statusMessage: "상태메세지3", Dday: "D-50")
        FollowersRow(followerImage: "User4", nickname: "닉네임4", statusMessage: "상태메세지4", Dday: "D-100")
    }
}
