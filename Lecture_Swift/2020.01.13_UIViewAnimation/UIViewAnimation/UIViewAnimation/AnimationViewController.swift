//
//  AnimationViewController.swift
//  UIViewAnimation
//
//  Created by giftbot on 2020. 1. 7..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import UIKit

final class AnimationViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var userIdTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var countDownLabel: UILabel!
    
    var count = 4 {
        didSet { countDownLabel.text = "\(count)" }
    }
    
    // MARK: - View LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.activityIndicatorView.isHidden = true
        userIdTextField.center.x = -view.frame.width
        passwordTextField.center.x = -view.frame.width
        loginButton.center.x = -view.frame.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addAnimateKeyframes()
        UIView.animate(withDuration: 1, delay: 1 , animations: {
            self.userIdTextField.center.x =
                //bounds를 써야하는 이유: frame은 부모기준이고 bound는 자기 자신이 기준임. frame.midX를 사용할 경우 userIdTextField.superview와 rootView의 leadingSpace만큼 오른쪽으로 더 이동되어 표시됨.
                (self.userIdTextField.superview?.bounds.midX)!
            
        })
        UIView.animate(withDuration: 1, delay: 2 , animations: {
            self.passwordTextField.center.x = (self.passwordTextField.superview?.bounds.midX)!
        })
        
        UIView.animate(withDuration: 1,
                       delay: 3,
                       usingSpringWithDamping: 0.5, //반동정도. 0~1사이에서 반동,1부터 반동없음
            initialSpringVelocity: 0,// 애니메이션 효과 속도 커질수록 빨라짐.
            options: [.curveEaseInOut/* .autoreverse, .repeat*/], //기본값curveEaseInOut 으로 빨라졌다가 스무스하게 느려지는 애니메이션 효과
            //autoreverse: 반대방향으로 애니메이션 실행 한번 더하기
            //repeat: 애니메이션 효과 무한 반복
            animations: {
                self.loginButton.center.x = (self.loginButton.superview?.bounds.midX)!
        }) {
            print($0)
        }
    }
    
    // MARK: - Action Handler
    
    @IBAction private func didEndOnExit(_ sender: Any) {}
    
    @IBAction private func login(_ sender: Any) {
        loginButtonAnimation()
        countDown()
        activityIndicatorView.isHidden = false
    }
    @IBOutlet weak var testView:UIView!
    
    func addAnimateKeyframes() {
        let initialFrame = testView.frame
        //animateKeyframes: 여러개의 animation효과를 순차적으로 한번에 주는 방법
        //addKeyframe을 여러개 설정하여 안에 담아주면 됨.
        //addKeyframe의 withRelativeStartTime과 relativeDuration은 animateKeyframes(withDuration: 5)에 대한 백분율로 기입됨.
        //예: withRelativeStartTime이 0.5 이면 5 * 0.5초가 됨.
        UIView.animateKeyframes(withDuration: 5,
         delay: 0,
        options: [],
        animations: {
         UIView.addKeyframe(withRelativeStartTime: 0,
                            relativeDuration: 0.3)
                    {
                        self.testView.center.x += 50
                        self.testView.center.y -= 200
                                    }
            UIView.addKeyframe(withRelativeStartTime: 0.3,
                               relativeDuration: 0.3)
        {
            self.testView.center.x += 150
            self.testView.center.y += 100
                        }
            UIView.addKeyframe(withRelativeStartTime: 0.6,
                               relativeDuration: 0.4)
        {
            self.testView.frame = initialFrame
                        }
                                    
        }) {  print($0)
        }
    }
    
    func loginButtonAnimation() {
        let initialFrame = loginButton.frame
        self.activityIndicatorView.startAnimating()
        UIView.animateKeyframes(
            withDuration: 2,
            delay: 0,
            options: [],
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 0.3) {
                        self.loginButton.center.x += 50
                        self.loginButton.center.y += 200
                }
                UIView.addKeyframe(
                    withRelativeStartTime: 0.3,
                    relativeDuration: 0.3) {
                        self.loginButton.center.x += 50
                        self.loginButton.center.y -= 100
                }
                UIView.addKeyframe(
                    withRelativeStartTime: 0.6,
                    relativeDuration: 0.4) {
                        self.loginButton.frame = initialFrame
                }
        })
    }
    
    func countDown() {
        self.countDownLabel.isHidden = false
        UIView.transition(
            with: self.countDownLabel,
            duration: 1,
            options: [.transitionFlipFromTop],
            animations: {
                self.count -= 1
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                guard self.count == 0 else { return self.countDown() }
                self.count = 4
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.isHidden = true
                self.countDownLabel.isHidden = true
            }
        }
    }
}
