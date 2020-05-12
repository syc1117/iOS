//
//  LoginViewController.swift
//  AppleLoginExample
//
//  Created by Giftbot on 2020/03/17.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit
import AuthenticationServices //apple로그인 구현할 때 필요함.

class LoginViewController: UIViewController {
  
  @IBOutlet private weak var stackView: UIStackView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAppleIDButton()
  }
  
  private func setupAppleIDButton() {
    if #available(iOS 13.0, *) {
        //apple버튼 생성
        let appleIDButton = ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)
    appleIDButton.cornerRadius = 20.0
        appleIDButton.addTarget(self, action: #selector(didTapAppleIDButton(_ :)), for: .touchUpInside)
    
    stackView.addArrangedSubview(appleIDButton)
    stackView.arrangedSubviews.first?.isHidden = true
    }
    
  }
  
  
  // MARK: Action
  
  @objc private func didTapAppleIDButton(_ sender: Any) {
    //apple버튼 request 설정
    //최초 애플로그인시 한번만 물어봄.
    //해당 서비스에서 email, fullName이 필요할 경우에만 설정해주면 됨.
    //email, fullName 모두 필요 없을 경우에는 idRequest.requestedScopes = [] 로 구현
    let idRequest = ASAuthorizationAppleIDProvider().createRequest()
    idRequest.requestedScopes = [.email, .fullName]
    
    //apple버튼 controller 생성해서 request 담고, delegate 2개 연결
    let authorizationController = ASAuthorizationController(authorizationRequests: [idRequest])
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = self
    authorizationController.performRequests() //authorizationController를 실행시키는 메서드
    
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    //어떤 window에 apple로그인 창을 띄울 것인가 결정하는 함수
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    //정상적으로 로그인 되었을 경우 호출되는 함수
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let idCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        
        
        //서버에 POST 해줄 값: tokenString
        guard let userToken = idCredential.identityToken,
        let tokenString = String(data: userToken, encoding: .utf8) else { return }
        print("=================\(tokenString)")
        
        let userID = idCredential.user //userID는 apple계정에 있는 유일한 고유값. 회원 탈퇴했다가 다시 가입해도 이 값은 변하지 않음.
        let familyName = idCredential.fullName?.familyName ?? ""//idRequest에서 요구하지 않았을 경우는 nil 값 반환됨.
        let givenName = idCredential.fullName?.givenName ?? ""//idRequest에서 요구하지 않았을 경우는 nil 값 반환됨.
        let email = idCredential.email ?? ""//idRequest에서 요구하지 않았을 경우는 nil 값 반환됨.
        
        let user = User(token: userToken, id: userID, familyName: familyName, givenName: givenName, email: email)
        print(user)
        
        if let encededData = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encededData, forKey: "AppleIDData")
        }
        
        switch idCredential.realUserStatus {
        case .likelyReal:
            print("아마도 실제 사용자일 가능성이 높음")
        case .unknown:
            print("실제 사용자인지 봇인지 확실치 않음") //추가 인증절차 구현
        case .unsupported:
            print("iOS가 아님, 이건 iOS에서만 지원")
        @unknown default: break
        }
        
        let vc = presentingViewController as! ViewController
        vc.user = user
        dismiss(animated: true)
    }
    
    //로그인 에러났을 때 호출
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        guard let error = error as? ASAuthorizationError else { return }
        switch error.code {
        case .unknown: //기기에 apple계정이 등록되어 있지 않을 경우
            print("unknown")
        case .canceled:
            print("canceled")
        case .invalidResponse: //서버통신에러
            print("invalidResponse")
        case .notHandled:
            print("notHandled")
        case .failed:
            print("failed")
        @unknown default:
            print("default")
        }
    }
    
}


