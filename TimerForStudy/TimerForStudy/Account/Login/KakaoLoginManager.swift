//
//  KakaoLoginManager.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2022/11/28.
//

import Foundation
import Combine
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

struct KakaoLoginManager {
    
    // MARK: - Properties
    let userInformationPublisher = PassthroughSubject<Account, KakaoLoginError>()
    
    /// 카카오 로그인 관련 에러
    enum KakaoLoginError: Error {
        case loginError
        case logoutError
        case informationFetchError
        case idFetchError
        case nicknameFetchError
        case undefined
    }
    
    /// 에러를 Alert 메시지로 변환
    /// - Parameter error: 에러
    /// - Returns: 메시지
    func convertErrorToMessage(_ error: KakaoLoginError) -> String {
        switch error {
        case .loginError:
            return "로그인 과정에서 오류가 발생했습니다."
        case .logoutError:
            return "로그아웃 과정에서 오류가 발생했습니다."
        case .informationFetchError:
            return "정보를 가져오지 못했습니다."
        case .idFetchError:
            return "회원번호를 가져오지 못했습니다."
        case .nicknameFetchError:
            return "닉네임을 가져오지 못했습니다."
        case .undefined:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
    
    func login() {
        // 카카오톡 간편 로그인이 가능한지 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            loginWithKakaoTalk()
        } else {
            loginWithKakaoAccount()
        }
    }
    
    // 카카오톡 앱이 있는 경우
    private func loginWithKakaoTalk() {
        UserApi.shared.loginWithKakaoTalk { (_, error) in
            guard error == nil else {
                userInformationPublisher.send(completion: .failure(.loginError))
                return
            }
            fetchUserInformation()
        }
    }
    
    // 카카오톡 앱이 없는 경우, 카카오 계정으로 로그인
    private func loginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount { (_, error) in
            guard error == nil else {
                userInformationPublisher.send(completion: .failure(.loginError))
                return
            }
            fetchUserInformation()
        }
    }
    
    // 유저의 회원번호와 닉네임을 조회하고 publish.
    private func fetchUserInformation() {
        UserApi.shared.me() { (user, error) in
            guard error == nil else {
                userInformationPublisher.send(completion: .failure(.informationFetchError))
                return
            }
            guard let id = user?.id as? Int64 else {
                userInformationPublisher.send(completion: .failure(.idFetchError))
                return
            }
            guard let name = user?.kakaoAccount?.profile?.nickname else {
                userInformationPublisher.send(completion: .failure(.nicknameFetchError))
                return
            }
            userInformationPublisher.send(Account(String(id), name))
        }
    }
    
    // 사용자 액세스 토큰과 리프레시 토큰을 모두 만료시켜, 더 이상 해당 사용자 정보로 카카오 API를 호출할 수 없도록 함.
    // 로그아웃은 요청 성공 여부와 상관없이 토큰을 삭제 처리.
    func logout() {
        UserApi.shared.logout { error in
            guard error == nil else {
                userInformationPublisher.send(completion: .failure(.logoutError))
                return
            }
        }
    }
}
