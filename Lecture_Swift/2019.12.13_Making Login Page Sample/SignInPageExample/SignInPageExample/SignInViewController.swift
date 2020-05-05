//
//  ViewController.swift
//  SignInPageExample
//
//  Created by 이봉원 on 11/11/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class SignInViewController: UIViewController {
  
  @IBOutlet private weak var signInFormView: UIView!
  @IBOutlet private weak var userIdTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  
  let userId = "qwer"
  let userPassword = "asdf"
  var isSignIn: Bool {
    UserDefaults.standard.bool(forKey: Key.isSignIn)
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    /***************************************************
     자동로그인 방법 (1)
     - 이전에 로그인 되어 있던 상태라면 로그인 화면이 나타나기 전에
       다음 화면(MainVC)을 애니메이션 없이 빠르게 띄우기
     ***************************************************/
    
    if isSignIn {
      let userId = UserDefaults.standard.string(forKey: Key.userId) ?? ""
      presentMainViewController(with: userId, animation: false)
      // viewWillAppear까지는 아직 뷰가 추가되지 않은 상태여서 present 불가
    }
  }
  
  func presentMainViewController(with userId: String, animation: Bool) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController")
    (mainVC as! MainViewController).userId = userId
    mainVC.modalPresentationStyle = .fullScreen
    present(mainVC, animated: animation)
  }
  
  
  @IBAction private func didTapSignInButton(_ sender: Any) {
    guard let userID = userIdTextField.text,
      let password = passwordTextField.text
      else { return }
    
    let clampedLetters = 4...16
    let isConditionSatisfied = (
      clampedLetters ~= userID.count
        && clampedLetters ~= userPassword.count
    )
    let isAuthenticated = (userID == self.userId && password == userPassword)
    
    if isAuthenticated, isConditionSatisfied {
      signIn(with: userID)
    } else {
      showAlert()
    }
  }
  
  func signIn(with userID: String) {
    UserDefaults.standard.set(true, forKey: Key.isSignIn)
    UserDefaults.standard.set(userID, forKey: Key.userId)
    print("로그인 수행 - 유저 아이디 저장 : \(userID)")
    
    userIdTextField.text?.removeAll()
    passwordTextField.text?.removeAll()
    presentMainViewController(with: userID, animation: true)
  }
  
  func showAlert() {
    let alertColor = UIColor.red.withAlphaComponent(0.6)
    userIdTextField.backgroundColor = alertColor
    passwordTextField.backgroundColor = alertColor
    
    UIView.animate(withDuration: 0.6) {
      self.userIdTextField.backgroundColor = .white
      self.passwordTextField.backgroundColor = .white
    }
  }
}



// MARK: - UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
  // 키보드가 나타나는 정확한 타이밍과 그 높이를 계산하는 것은 차후 배울 예정
  // UIView 애니메이션을 쓰는 정확한 타이밍도 그 때 함께 사용
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    UIView.animate(withDuration: 0.3) {
      self.signInFormView.frame.origin.y -= 100
    }
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    // editingChanged 메서드와 달리 이 메서드에서는
    // textfield.text, range, string을 모두 조합해야 정확한 텍스트 입력 처리 가능
    
    guard let text = textField.text,
      let range = Range(range, in: text)
      else { return true }
    
    let newText = text.replacingCharacters(in: range, with: string)
    return newText.count < 20
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    UIView.animate(withDuration: 0.3) {
      self.signInFormView.frame.origin.y += 100
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    didTapSignInButton(textField)
    textField.resignFirstResponder()
    return true
  }
}
