//
//  LoginViewController.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2022/11/28.
//

import UIKit
import Combine
import AuthenticationServices

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var kakaoLoginManager = KakaoLoginManager()
    private lazy var subscriptions = [AnyCancellable]()
    
    private var loginButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = LayoutConstants.buttonSpacing
        
        return stackView
    }()
    
    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setBackgroundImage(UIImage(named: "kakaologinimage"), for: .normal)
        button.addTarget(self, action: #selector(kakaoLogin), for: .touchUpInside)
        
        button.addConstraints([
            button.widthAnchor.constraint(equalToConstant: LayoutConstants.buttonWidth),
            button.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight)
        ])
        
        return button
    }()
    
    private lazy var appleLoginButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        
        button.addTarget(self, action: #selector(appleLogin), for: .touchUpInside)
        
        button.addConstraints([
            button.widthAnchor.constraint(equalToConstant: LayoutConstants.buttonWidth),
            button.heightAnchor.constraint(equalToConstant: LayoutConstants.buttonHeight)
        ])
        
        return button
    }()
    
    private lazy var errorAlert: UIAlertController = {
        let alert = UIAlertController(title: "오류", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
        
        return alert
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        setUpHierachy()
        setUpLayout()
    }
    
    private func setUpHierachy() {
        [kakaoLoginButton, appleLoginButton].forEach {
            loginButtonStackView.addArrangedSubview($0)
        }
        
        [loginButtonStackView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            loginButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButtonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func alertWillAppear(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if !self.errorAlert.isBeingPresented {
                self.errorAlert.message = message
                self.present(self.errorAlert, animated: true)
            }
        }
    }
}

// MARK: - Button Action
extension LoginViewController {
    @objc func kakaoLogin() {
        kakaoLoginManager.userInformationPublisher.sink(receiveCompletion: { [weak self] error in
            guard let self = self else { return }
            switch error {
            case .failure(.loginError):
                self.alertWillAppear(ErrorMessage.loginError)
            case .failure(.logoutError):
                self.alertWillAppear(ErrorMessage.logoutError)
            case .failure(.informationFetchError):
                self.alertWillAppear(ErrorMessage.informationFetchError)
            case .failure(.idFetchError):
                self.alertWillAppear(ErrorMessage.idFetchError)
            case .failure(.nicknameFetchError):
                self.alertWillAppear(ErrorMessage.nicknameFetchError)
            case .finished:
                break
            }
        }, receiveValue: { information in
            // Create an account
            dump(information)
        })
        .store(in: &subscriptions)
        
        kakaoLoginManager.login()
    }
    
    @objc func appleLogin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    // 로그인 실패: 에러 처리
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        alertWillAppear(ErrorMessage.loginError)
    }
    
    // 로그인 성공
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        // 애플 계정과 비밀번호를 사용하여 로그인
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // Create an account
            let id = appleIDCredential.user
            guard let lastName = appleIDCredential.fullName?.familyName else {
                alertWillAppear(ErrorMessage.nameFetchError)
                return
            }
            guard let firstName = appleIDCredential.fullName?.givenName else {
                alertWillAppear(ErrorMessage.nameFetchError)
                return
            }
            Account(id, lastName + firstName)
            
        // 기존 iCloud Keychain을 사용하여 로그인
        case let passwordCredential as ASPasswordCredential:
//            let username = passwordCredential.user
//            let password = passwordCredential.password
            break
            
        default:
            break
        }
    }
}

// 앱의 윈도우에서 애플 로그인 컨텐츠 제공
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        view.window!
    }
}

private enum LayoutConstants {
    static let buttonSpacing: CGFloat = 20
    static let buttonWidth: CGFloat = 280
    static let buttonHeight: CGFloat = 45
}

private enum ErrorMessage {
    static let loginError = "로그인 과정에서 오류가 발생했습니다."
    static let logoutError = "로그아웃 과정에서 오류가 발생했습니다."
    static let informationFetchError = "정보를 가져오지 못했습니다."
    static let idFetchError = "회원번호를 가져오지 못했습니다."
    static let nicknameFetchError = "닉네임을 가져오지 못했습니다."
    static let nameFetchError = "이름을 가져오지 못했습니다."
}
