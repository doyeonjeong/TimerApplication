//
//  MyProfileRow.swift
//  TimerForStudy
//
//  Created by Doyeon on 2023/01/12.
//

import SwiftUI

struct MyProfileRow: View {
    var body: some View {
        HStack {
            // MyProfile
            Image("MyProfile")
                .resizable()
                .clipShape(Circle())
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
            VStack(alignment: .leading, spacing: 15) {
                Text("닉네임")
                    .bold()
                    .font(.title2)
                Text("상태메세지")
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            Text("D-Day")
                .padding(6)
                .background(content: {
                    Color.gray.opacity(0.20)
                })
                .cornerRadius(10)
        }//: HStack
        .frame(height: 120)
        .padding(.leading, -16)
        .padding(.top, -16)
    }
}

struct MyProfileRow_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileRow()
    }
}
