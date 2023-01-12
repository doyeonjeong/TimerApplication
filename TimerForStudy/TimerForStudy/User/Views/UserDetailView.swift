//
//  UserSettingView.swift
//  TimerForStudy
//
//  Created by Doyeon on 2023/01/11.
//

import SwiftUI

struct UserDetailView: View {
    
    var profileImage = "MyProfile"
    @State private var nickName = "테스트닉네임"
    
    var body: some View {
        NavigationView {
            List {
                VStack {
                    Image(profileImage)
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                    Button {
                        print("사진 수정 버튼")
                    } label: {
                        Text("변경")
                            .padding(8)
                            .foregroundColor(.black)
                            .background {
                                Color(UIColor.background1!)
                            }
                            .cornerRadius(8)
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        TextField("닉네임", text: $nickName)
                            .font(.title2)
                        Spacer()
                        Button {
                            print("닉네임 수정 버튼")
                        } label: {
                            Text("변경")
                                .padding(8)
                                .foregroundColor(.black)
                                .background {
                                    Color(UIColor.background1!)
                                }
                                .cornerRadius(8)
                        }
                        
                    }//: HStack
                    .padding(.all, 8)
                    
                    HStack {
                        Text("상태메세지")
                            .font(.title2)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Button {
                            print("상태메세지 수정 버튼")
                        } label: {
                            Text("변경")
                                .padding(8)
                                .foregroundColor(.black)
                                .background {
                                    Color(UIColor.background1!)
                                }
                                .cornerRadius(8)
                        }
                    }//: HStack
                    .padding(.all, 8)
                    
                    HStack {
                        Text("기존 목표 (비공개)")
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Button {
                            print("목표 수정 버튼")
                        } label: {
                            Text("변경")
                                .padding(8)
                                .foregroundColor(.black)
                                .background {
                                    Color(UIColor.background1!)
                                }
                                .cornerRadius(8)
                        }
                    }//: HStack
                    .padding(.all, 8)

                    HStack {
                        Text("D-day (공개)")
                            .font(.title3)
                        Spacer()
                        Button {
                            print("D-Day 수정 버튼")
                        } label: {
                            Text("변경")
                                .padding(8)
                                .foregroundColor(.black)
                                .background {
                                    Color(UIColor.background1!)
                                }
                                .cornerRadius(8)
                        }
                    }//: HStack
                    .padding(.all, 8)

                }//: VStack
                .padding(.vertical, 8)
//                .frame(width: .infinity)
                
            }//: VStack
        }//: List
//        .navigationTitle("내 정보")
//        .navigationBarTitleDisplayMode(.inline)
    }//: NavigationView
}

struct UserSettingView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView()
    }
}
