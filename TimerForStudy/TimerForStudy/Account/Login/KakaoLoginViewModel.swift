//
//  KakaoLoginVM.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2022/11/28.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import Combine

/// 카카오 로그인 View Model Object
final class KakaoLoginViewModel {
    enum LoginError: Error {
        case undefined
    }
    
    // MARK: - Properties
    // 카카오 로그인을 통해 받아올 고유한 식별번호
    let userIdPublisher = PassthroughSubject<Int, Never>()
    let userNicknamePublisher = PassthroughSubject<String, Never>()
    
    func kakaoLogin() {
        // 카카오톡 간편 로그인이 가능한지 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            loginWithKakaoTalk()
        } else {
            loginWithKakaoAccount()
        }
    }
    
    // 카카오톡 앱이 있는 경우
    func loginWithKakaoTalk() {
        UserApi.shared.loginWithKakaoTalk { [weak self] (_, error) in
            guard let self = self else { return }
            
            if let error = error {
                // 예외 처리
            } else {
                self.fetchUserId()
            }
        }
    }
    
    // 카카오톡 앱이 없는 경우, 카카오 계정으로 로그인
    func loginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount { [weak self] (_, error) in
            guard let self = self else { return }
            
            if let error = error {
                // 예외 처리
            } else {
                self.fetchUserId()
            }
        }
    }
    
    // 유저의 회원번호 값을 조회하고 userId에 할당.
    func fetchUserId() {
        UserApi.shared.me() { [weak self] (user, error) in
            if let error = error {
                // 예외 처리
            } else {
                guard let userNumber = user?.id as? Int64 else { return }
                self?.userIdPublisher.send(Int(userNumber))
                
                guard let userNickname = user?.kakaoAccount?.profile?.nickname else { return }
                self?.userNicknamePublisher.send(userNickname)
                
                self?.kakaoLogout()
            }
        }
    }
    
    // 사용자 액세스 토큰과 리프레시 토큰을 모두 만료시켜, 더 이상 해당 사용자 정보로 카카오 API를 호출할 수 없도록 함.
    // 로그아웃은 요청 성공 여부와 상관없이 토큰을 삭제 처리.
    func kakaoLogout() {
        UserApi.shared.logout {(error) in
            if let error = error {
                // 예외 처리
            }
        }
    }
}
