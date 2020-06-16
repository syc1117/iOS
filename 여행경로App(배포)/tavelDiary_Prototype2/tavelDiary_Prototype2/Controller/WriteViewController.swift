//
//  WriteViewController.swift
//  tavelDiary_Prototype2
//
//  Created by 신용철 on 2020/02/24.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import MapKit

class WriteViewController: UIViewController {
    
    let superViewOfTextView = UITableView()
    let titleLabel = UILabel()
    let scheduleLabel = UILabel()
    let scheduleStartLabel = UILabel()
    let scheduleEndLabel = UILabel()
    let pathLabel = UILabel()
    let totalDistanceLabel = UILabel()
    let titelTextField = UITextField()
    let titleProgressView = UIProgressView()
    let schedulStartButton = UIButton()
    let schedulStartProgressView = UIProgressView()
    let scheduleEndButton = UIButton()
    let scheduleEndProgressView = UIProgressView()
    let pathContent = UILabel()
    let pathButton = UIButton()
    let memoLabel = UILabel()

    
    // MARK: coreData 저장을 위한 프로퍼티
    var tripTitle: String = "" // 여행제목
    var startingDate: String = "" // 여행시작일
    var endDate: String = "" // 여행 종료일
    var distance: Double = 0.0 // 총 경로 거리
    var navigationPath: String = "" // 여행경로
    var annotationArray: [MKPointAnnotation] = [] // annotation.title, annotation 위 경도
    
    //수정을 위해서 detailView에서 던져준 데이터를 저장할 프로퍼티 선언
    var data: Data?
    
    //캘린더에서 넘어온 날짜 데이터 저장
    var startSelectedDateInt: Int = 0
    var startselectedYearInt: Int = 0
    var startselectedMonthInt: Int = 0
    
    var endSelectedDateInt: Int = 0
    var endSelectedYearInt: Int = 0
    var endSelectedMonthInt: Int = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        notificationCenter()
        if data != nil {
            self.title = "여행정보 수정"
        } else {
            self.title = "새 여행"
            schedulStartButton.setTitle("여행 시작일을 설정하세요!", for: .normal)
            scheduleEndButton.setTitle("여행 종료일을 설정하세요!", for: .normal)
            pathContent.text = "여행경로를 설정하세요!"
            
            schedulStartButton.setTitleColor(.lightGray, for: .normal)
            scheduleEndButton.setTitleColor(.lightGray, for: .normal)
            pathContent.textColor = .lightGray
        }
        
        view.backgroundColor = .white
        let backButton = UIBarButtonItem(title: "취소", style: .done, target: self, action: #selector(didTouchCancel))
        navigationItem.leftBarButtonItem = backButton
        let rightBarButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(didTouchSave))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func didTouchCancel(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTouchSave(){
        
        if let data = self.data {

            let latitude = self.annotationArray.compactMap {
                $0.coordinate.latitude
            }
            
            let longitude = self.annotationArray.compactMap {
                $0.coordinate.longitude
            }
            
            let titleArray = self.annotationArray.compactMap { $0.title }
            
            data.tripTitle = self.tripTitle
            data.startingDate = self.startingDate
            data.endDate = self.endDate
            data.distance = self.distance
            data.navigationLabel = self.navigationPath
            data.titleArray = titleArray
            data.longitude = longitude
            data.latitude = latitude
            
            if let text = (superViewOfTextView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! textViewCell).textView.text {
                data.memo = text
            }
            DataBase.shared.saveContext()
            
            navigationController?.popToRootViewController(animated: true)
            
        } else {
            guard self.startselectedYearInt <= endSelectedYearInt,
                self.startselectedMonthInt <= endSelectedMonthInt,
                self.startSelectedDateInt <= self.endSelectedDateInt else {
            let alert = UIAlertController(title: "날짜 선택 오류", message: "여행 종료일이 시작일보다 빠릅니다.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .destructive)
            print("startingDate\(startingDate)")
            print("endDate\(endDate)")
            alert.addAction(action)
            present(alert, animated: true)
            return }
        
        let latitude = self.annotationArray.compactMap {
            $0.coordinate.latitude
        }
        
        let longitude = self.annotationArray.compactMap {
            $0.coordinate.longitude
        }
        
        let titleArray = self.annotationArray.compactMap { $0.title }
            
            
        var memoText = ""
        if let text = (superViewOfTextView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! textViewCell).textView.text {
                memoText = text
            }
        
        DataBase.shared.addCoreData(tripTitle: self.tripTitle,
                                    startingDate: self.startingDate,
                                    endDate: self.endDate,
                                    distance: self.distance,
                                    navigationLabel: self.navigationPath,
                                    titleArray: titleArray,
                                    longitude: longitude,
                                    latitude: latitude,
                                    memo: memoText)
            
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func didTouchPathButton(){
        let scv = SearchPathController()
        navigationController?.pushViewController(scv, animated: true)
    }
    
    @objc private func didTouchScheduleButton(_ sender: UIButton){
        
        if sender.tag == 0 {
            let clv = CalendarViewController()
            clv.title = "여행 시작일을 선택하세요"
            navigationController?.pushViewController(clv, animated: true)
        } else if sender.tag == 1 {
            let clv = CalendarViewController()
            clv.title = "여행 종료일을 선택하세요"
            navigationController?.pushViewController(clv, animated: true)
        }
    }
    
    @objc func editTextfield(_ sender: UITextField){
        self.titelTextField.text = sender.text
        self.tripTitle = sender.text ?? ""
    }
    var cons: NSLayoutConstraint?
    func setupView(){
        view.addSubviews([titleLabel, scheduleLabel,titelTextField,scheduleStartLabel,scheduleEndLabel, schedulStartButton,scheduleEndButton,pathLabel,pathContent,totalDistanceLabel ,pathButton,memoLabel,superViewOfTextView, titleProgressView, schedulStartProgressView, scheduleEndProgressView])

        superViewOfTextView.backgroundColor = .white
        superViewOfTextView.dataSource = self
        superViewOfTextView.register(textViewCell.self, forCellReuseIdentifier: "cell")
        superViewOfTextView.delegate = self
        superViewOfTextView.estimatedRowHeight = 50
        superViewOfTextView.rowHeight = UITableView.automaticDimension
        
        titleLabel.layout.top(constant: 20).leading(constant: 10)
        titleLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        scheduleLabel.layout.top(equalTo: titleLabel.bottomAnchor, constant: 30).leading(constant: 10)
        scheduleLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        scheduleStartLabel.layout.top(equalTo: scheduleLabel.bottomAnchor, constant: 20).leading(constant: 40).width(constant: 50)
        schedulStartProgressView.layout.top(equalTo: scheduleStartLabel.bottomAnchor, constant: 10).leading(constant: 40).trailing(constant: -15)
        
        scheduleEndLabel.layout.top(equalTo: schedulStartProgressView.bottomAnchor, constant: 20).leading(constant: 40).width(constant: 50)
        scheduleEndProgressView.layout.top(equalTo: scheduleEndLabel.bottomAnchor, constant: 10).leading(constant: 40).trailing(constant: -15)
        
        titelTextField.layout.centerY(equalTo: titleLabel.centerYAnchor).leading(equalTo:titleLabel.trailingAnchor, constant: 10).trailing(constant: -10)
        
        titleProgressView.layout.top(equalTo: titelTextField.bottomAnchor, constant: 10).leading(constant: 15).trailing(constant: -15)
       
        schedulStartButton.layout.centerY(equalTo: scheduleStartLabel.centerYAnchor).leading(equalTo: scheduleLabel.trailingAnchor, constant: 10).trailing(constant: -10)
        schedulStartButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        scheduleEndButton.layout.centerY(equalTo: scheduleEndLabel.centerYAnchor).leading(equalTo: scheduleLabel.trailingAnchor, constant: 10).trailing(constant: -10)
        scheduleEndButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        pathLabel.layout.top(equalTo: scheduleEndButton.bottomAnchor, constant: 30).leading(constant: 10).width(constant: 70)
        
        pathContent.layout.top(equalTo: pathLabel.topAnchor).leading(equalTo: pathLabel.trailingAnchor, constant: 10).trailing(constant: -10)
        
        pathButton.layout.top(equalTo: pathContent.topAnchor).trailing(equalTo: pathContent.trailingAnchor).bottom(equalTo: pathContent.bottomAnchor).leading(equalTo: pathContent.leadingAnchor)
       
        memoLabel.layout.top(equalTo: pathContent.bottomAnchor, constant: 20).leading(constant: 10)
        
        superViewOfTextView.layout.top(equalTo: memoLabel.bottomAnchor, constant: 10).leading(constant: 10).trailing(constant: -10).bottom()
        cons = superViewOfTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        cons?.isActive = true
        
        [titleLabel, scheduleLabel, pathLabel, memoLabel].forEach {
            $0.font = UIFont.systemFont(ofSize: 18)
            $0.textColor = .darkGray
        }
        
        titleLabel.text = "여행 제목"
        
        scheduleLabel.text = "여행 일정"
        
        scheduleStartLabel.text = "시작일"
        scheduleStartLabel.font = UIFont.systemFont(ofSize: 15)
        scheduleStartLabel.textColor = .darkGray
        
        scheduleEndLabel.text = "종료일"
        scheduleEndLabel.font = UIFont.systemFont(ofSize: 15)
        scheduleEndLabel.textColor = .darkGray
        
        pathLabel.text = "여행경로"
        pathLabel.font = UIFont.systemFont(ofSize: 18)
        pathContent.font = UIFont.systemFont(ofSize: 18)
        pathContent.setContentHuggingPriority(.required, for: .vertical)
        
        totalDistanceLabel.text = ""
        totalDistanceLabel.font = UIFont.systemFont(ofSize: 18)
        
        memoLabel.text = "메모"
        
        
        scheduleStartLabel.tag = 0
        schedulStartButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        schedulStartButton.contentVerticalAlignment = .center
        schedulStartButton.contentHorizontalAlignment = .left
        schedulStartButton.addTarget(self, action: #selector(didTouchScheduleButton), for: .touchUpInside)
       
        
        scheduleEndButton.tag = 1
        scheduleEndButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        scheduleEndButton.contentVerticalAlignment = .center
        scheduleEndButton.contentHorizontalAlignment = .left
        scheduleEndButton.addTarget(self, action: #selector(didTouchScheduleButton), for: .touchUpInside)
        
        pathButton.addTarget(self, action: #selector(didTouchPathButton), for: .touchUpInside)
        
        pathContent.lineBreakMode = .byWordWrapping
        pathContent.numberOfLines = 20
        pathContent.textAlignment = .natural
        
        titelTextField.font = UIFont.systemFont(ofSize: 18) //
        titelTextField.borderStyle = .none //모서리가 둥근 사각형
        titelTextField.adjustsFontSizeToFitWidth = true //글자수 초과하면 글자수 작아짐(미니멈으로 설정한 데 까지)
        titelTextField.placeholder = "여행 제목을 입력하세요!"
        titelTextField.returnKeyType = .done
        titelTextField.addTarget(self, action: #selector(editTextfield), for: .editingChanged)
    }
    
    //viewDidLoad에 삽입
    func notificationCenter(){
        // MARK: keyboard가 나타날때 호출되는 noti
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(didReceiveKeyboardNoti),
                name: UIResponder.keyboardWillShowNotification,
                object: nil)
        // MARK: keyboard가 사라질때 호출되는 noti
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(didReceiveKeyboardNoti),
                name: UIResponder.keyboardWillHideNotification,
                object: nil)
        // MARK: app이 active상태가 될 때 호출되는 함수 - 공지사항등의 팝업창 생성시 사용
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(didReceiveKeyboardNoti),
                         name: UIApplication.didBecomeActiveNotification,
                         object: nil)
    }
    
    @objc func didReceiveKeyboardNoti (_ sender: Notification){
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = sender.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        UIView.animate(withDuration: duration) {
            
            if keyboardFrame.minY >= self.view.frame.maxY {
                self.cons?.constant = 0
            } else {
                self.cons?.constant = -keyboardFrame.height
            }
        }
    }
    
}

extension WriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! textViewCell
        
        if let data = self.data?.memo {
            cell.textView.text = data
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
}
