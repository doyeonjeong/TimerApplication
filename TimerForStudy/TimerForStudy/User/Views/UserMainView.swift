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
                
                Section {
                    // Followers
                    HStack {
                        // User1
                        Image("User1")
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        VStack(alignment: .leading, spacing: 15) {
                            Text("닉네임")
                                .bold()
                                .font(.title3)
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
                    .frame(height: 80)
                    .padding(.leading, -16)
                    
                    HStack {
                        // User2
                        Image("User2")
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        VStack(alignment: .leading, spacing: 15) {
                            Text("닉네임")
                                .bold()
                                .font(.title3)
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
                    .frame(height: 80)
                    .padding(.leading, -16)
                    
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
