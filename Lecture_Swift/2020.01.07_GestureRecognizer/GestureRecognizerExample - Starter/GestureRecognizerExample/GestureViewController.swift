//
//  GestureViewController.swift
//  GestureRecognizerExample
//
//  Created by giftbot on 2020/01/04.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit
/*학습목표
 1. Tab제스쳐, rotation 제스쳐
 
 
 과제
 1. tab: 더블 클릭하면 이미지가 2배로 켜지고 다시 더블 클릭하면 원래상태로 돌아온다
 2. rotation: 마우스 클릭하고 회전 시키면 이미지가 같이 회전한다.
 3. swipe: 좌우방향 드래그 별로 이미지가 바뀐다.
 4. pan: 이미지 클릭해서 드래그하면 이미지가 따라서 움직인다
 5. long: 이미지를 오래 클릭하면 휴대폰에 진동이 발생한다.*/
final class GestureViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    let label: UILabel = {
        let label = UILabel()
        label.text = "1111"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        return label
    }()
  // MARK: 질문 cornerRadius 안먹힘
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true // 삐져나온 이미지만 잘라주는 것이고 실제로는 네모모양 전체 프레임이 살아있어서 그림 밖을 선택해서 드래그해도 pen제스쳐가 작동함. 이를 방지하기 위해서는 수학적으로 그림의 프레임을 계산해서 그 안에 touchPoint가 들어가 있을 때만 작동하도록 해주어야 함.ㅇ
        view.addSubview(label)
        
        
        label.frame = CGRect(x: 300, y: 300, width: 100, height: 100)
    }
    var trueFalse = true
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        print("tap")
        //탭 상태가 확실히 손가락 때지는것 까지 확인 되었는지 확인하고 실행
        guard sender.state == .ended else { return }
        if trueFalse {
            //이미지 변형할 때 transform 사용
            // scaledBy 는 몇 배로 바꿀건지
            // translatedBy 는 좌표 이동
            imageView.transform = imageView.transform.scaledBy(x: 2, y: 2)
        } else {
            //CGAffineTransform.identity => transform 되기 전 상태(원본)로 복원
            imageView.transform = CGAffineTransform.identity
        }
        //탭이 한번 실행 될때마다 true/false 자동 변환
        trueFalse.toggle()
    }
    @IBAction func rotationGesture(_ sender: UIRotationGestureRecognizer) {
        //sender의 rotation정보에 맞춰 이미지 뷰가 rotate 한다.
        imageView.transform = imageView.transform.rotated(by: sender.rotation)
        //아래 코드가 없으면 rotation값이 계속해서 중첩되어 회전속도가 너무 빨라짐.
        sender.rotation = 0
    }
    // MARK: 질문 - sender.direction = .right 를 안하면 작동 안되는 이유
    @IBAction func swipeGesture(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            imageView.image = UIImage(named: "cat2")
            label.text = "left"
            sender.direction = .right //안해주면 왼쪽만 먹게되고 오른쪽은 안먹음, 코드의 뜻은 오른쪽을 스와이프로 작동되게 해주겠다는 의미, 반대로 else밑에는 왼쪽으로 작동되게 해주겠다는 것.
        } else {
            imageView.image = UIImage(named: "cat1")
            label.text = "right"
            sender.direction = .left
        }
    }
    var initialCenter = CGPoint() // GPoint.zero와 같음
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        guard let dragView = sender.view else { return }
        //sender.view = imageView임. UIPanGestureRecognizer를 스토리보드에서 imageView에 올렸기 때문
        //GestureRecognizer를 view가 아닌 imageView에 올렸을 때는 imageView의 isUserInteractionEnabled값이 false로 되어있기 때문에 GestureRecognizer가 작동하지 않음. 따라서, 메인스토리보드의 attribute inspector에서 UserInteraction Enabled를 클릭해주거나 아래 코드를 사용해야함.
        dragView.isUserInteractionEnabled = true
        //dragView.superview = view
        //seder.translation = Drag하는 좌표값. 여기서 중요한 것은 변화된 좌표 값이지 클릭한 위치 정보가 아니라는 것임. 어디서 drag를 시작하던 움직인 변화량만 가짐. 따라서 이걸 사용하기 위해서는 gesture를 심은 객채의 초기 위치값(initialCenter)를 만들어 주어야함.
        //let translation = view를 기준으로 drag되고 있는 좌표값
        let translation = sender.translation(in: dragView.superview)
        
        //Pangesture는 continue이므로 changed가 계속 발생하다가 끝나는 구조이기 때문에 상태값 구분을 하여 코드 작성이 필요함.
        if sender.state == .began {
            //drageView(=imageView)의 최초 값을 가지고 있어야 함.
            self.initialCenter = dragView.center
             print("\(initialCenter)111")
        }
        //change, ended, began 일때 작동
        if sender.state != .cancelled {
            dragView.center = CGPoint(x: initialCenter.x + translation.x,
                                      y: initialCenter.y + translation.y)
           
        } else { //cancel일 때 작동
            dragView.center = initialCenter
            print("\(initialCenter)222")
            //?????작성 안하면 어떻게 되지? 시뮬레이터 상으로는 확인 불가
        }
    }
}
