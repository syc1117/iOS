//
//  ComposeViewController.swift
//  MemoSYC
//
//  Created by 신용철 on 2020/06/15.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    //editTarget에 값이 있는 지 여부에 따라 '메모 수정'과 '새 메모' 모드를 구분함.
    var editTarget: Memo?
    
    let textView = UITextView()
    
    var willShowToken: NSObjectProtocol?
    var willHideToken: NSObjectProtocol?
    
    deinit {
        if let token = willShowToken {
            NotificationCenter.default.removeObserver(token)
        }
        
        if let token = willHideToken {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        textView.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        willShowToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
            guard let strongSelf = self else { return }
            if let frame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                //keyboard 높이 값 저장
                let heigt = frame.cgRectValue.height
                //textView의 아래 여백을 keyboard 높이 만큼 추가
                var inset = strongSelf.textView.contentInset
                inset.bottom = heigt
                //bottom 여백을 제외한 다른 부분 여백은 기존대로 저장
                strongSelf.textView.contentInset = inset
                
                //textView의 scrollBar의 아래 여백에도 같은 높이를 추가해야함.
                inset = strongSelf.textView.scrollIndicatorInsets
                inset.bottom = heigt
                strongSelf.textView.scrollIndicatorInsets = inset
            }
        })
        
        willHideToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
            guard let strongSelf = self else { return }
            
            var inset = strongSelf.textView.contentInset
            inset.bottom = 0
            strongSelf.textView.contentInset = inset
            
            inset = strongSelf.textView.scrollIndicatorInsets
            inset.bottom = 0
            strongSelf.textView.scrollIndicatorInsets = inset
        })
    }
    
    @objc func barbutton(sender: UIBarButtonItem) {
        
        if sender.tag == 0 {
            dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
        } else {
            guard let memo = self.textView.text, memo.count > 0 else {
                alert(title: "알림", message: "메모내용이 없습니다.")
                return
            }
            if editTarget == nil {
                DataManager.shared.addNewMemo(memo)
                NotificationCenter.default.post(name: ComposeViewController.newMemoDidInsert, object: nil)
                dismiss(animated: true, completion: nil)
            } else {
                editTarget?.content = self.textView.text
                editTarget?.insertDate = Date()
                DataManager.shared.saveContext()
                navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

extension ComposeViewController {
    func setupUI() {
        if self.editTarget == nil {
            title = "새 메모"
        } else {
            title = "메모 수정"
            self.textView.text = self.editTarget?.content
        }
        view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(barbutton))
        cancelButton.tag = 0
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(barbutton))
        saveButton.tag = 1
        
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton
        
        view.addSubview(textView)
        textView.frame = view.frame
        textView.font = UIFont.systemFont(ofSize: 20)
    }
    
    static let newMemoDidInsert = Notification.Name(rawValue: "newMemoDidInsert")
    
}
