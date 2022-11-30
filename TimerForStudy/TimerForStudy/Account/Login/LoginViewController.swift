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
    private lazy var kakaoLoginManager = KakaoLoginManager()
    private lazy var subscriptions = [AnyCancellable]()
    
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
                self.alertWillAppear(self.kakaoLoginManager.convertErrorToMessage(.loginError))
            case .failure(.logoutError):
                self.alertWillAppear(self.kakaoLoginManager.convertErrorToMessage(.logoutError))
            case .failure(.informationFetchError):
                self.alertWillAppear(self.kakaoLoginManager.convertErrorToMessage(.informationFetchError))
            case .failure(.idFetchError):
                self.alertWillAppear(self.kakaoLoginManager.convertErrorToMessage(.idFetchError))
            case .failure(.nicknameFetchError):
                self.alertWillAppear(self.kakaoLoginManager.convertErrorToMessage(.nicknameFetchError))
            case .failure(.undefined):
                self.alertWillAppear(self.kakaoLoginManager.convertErrorToMessage(.undefined))
            case .finished:
                break
            }
        }, receiveValue: { information in
            dump(information)
        })
        .store(in: &subscriptions)
        
        kakaoLoginManager.login()
    }
}

private struct LayoutConstants {
    static let buttonOffset: CGFloat = 20
    static let buttonWidth: CGFloat = 280
    static let buttonHeight: CGFloat = 45
}
