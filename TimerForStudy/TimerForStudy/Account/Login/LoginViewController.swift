//
//  LoginViewController.swift
//  TimerForStudy
//
//  Created by 김동욱 on 2022/11/28.
//

import UIKit
import Combine

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private var kakaoLoginViewModel = KakaoLoginViewModel()
    private var subscriptions = [AnyCancellable]()
    
    private var loginButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = LayoutConstants.buttonOffset
        
        return stackView
    }()
    
    private lazy var kakaoLoginButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setBackgroundImage(UIImage(named: "kakaologinimage"), for: .normal)
        button.addTarget(self, action: #selector(kakaoLogin), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        configure()
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        setUpHierachy()
        setUpLayout()
    }
    
    private func setUpHierachy() {
        [kakaoLoginButton].forEach {
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
    
    private func configure() {
        kakaoLoginViewModel.userIdPublisher.sink { id in
            // Handling User ID
            print("User ID: \(id)")
        }
        .store(in: &subscriptions)
        
        kakaoLoginViewModel.userNicknamePublisher.sink { nickname in
            // Handling User Nickname
            print("User Nickname: \(nickname)")
        }
        .store(in: &subscriptions)
    }
}

// MARK: - Button Action
extension LoginViewController {
    @objc func kakaoLogin() {
        kakaoLoginViewModel.kakaoLogin()
    }
}

private struct LayoutConstants {
    static let buttonOffset: CGFloat = 20
    static let buttonWidth: CGFloat = 280
    static let buttonHeight: CGFloat = 60
}
