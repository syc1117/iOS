//
//  TouchViewController.swift
//  GestureRecognizerExample
//
//  Created by giftbot on 2020/01/04.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

/*학습포인트
 1. touchesBegan, touchesMoved, touchesEnded, touchesCancelled의 작동 시기
 2. touchesEnded와 touchesCancelled를 동시에 구현하는 이유
   - touchesBegan으로 실행되는 코드가 있을 때 시스템 이벤트로 cancel이 발생하는 경우, touchesEnded가 실행되야 하는데 실해되지 않고 touchesBegan상태에서 종료될 수 있음.
 3. touchPoint를 구할 수 있다.(터치한 좌표 값)
 4. tougchPoint를 활용한다
 */
/*학습 과제
 1. view아무대나 클릭 했을 때 고양이 이미지가 변경되었다가 클릭이 종료되면 원래 이미지로 돌아오는 것 구현
 2. 1번과 마찬가지 기능이지만 고양이 이미지 내부에서만 해당 기능이 작동하도록 구현
 3. 이미지를 마우스 위치에 따라서 같이 움직이도록 구현
 4. 이미지가 움직이되 이미지의 중앙이 마우스 포인트를 따라 움직이지 않고 클릭한 부분에서 따라 움직이도록 구현: class에 var lastTouchPoint = CGPoint.zero를 구현한 후 touchesBegan 구문에서 클릭한 좌표를 lastTouchPoint에 할당한 후 touchesMoved 에서 imageView.center - lastTouchPoint로
 
 */

final class TouchViewController: UIViewController {

  @IBOutlet private weak var imageView: UIImageView!
  
  var isHolidingImage = false
    //touchesBegan에서 액션이 발생하면 isHolidingImage이 true가 되게 하고 이것이 true일 때 touchesMoved가 호출되도록 touchesMoved 안에 if 조건으로 설정함. 여기서는 touchesBegan에서 설정한 imageView를 클릭하고 나면 마우스를 따라 이동하도록 하기 위해서임. 만약 이렇게 하지 않고 touchesMoved안에 imageView.frame.contains(touchPoint)를 구현할 경우 드래그 중 마우스 포인터가 이미지를 벗어날 경우 false가 되면서 이미지가 따라오다가 멈추게 됨.
    var lastTouchPoint = CGPoint.zero
    
  override func viewDidLoad() {
    super.viewDidLoad()
    //imageView를 동그랗게 변형
    imageView.layer.cornerRadius = imageView.frame.width / 2
    //imageView를 벗어나는 이미지 부분을 제거: clipsToBounds 대신 imageView.layer.masksToBounds를 사용해도 됨.
//    imageView.clipsToBounds = true
    imageView.layer.masksToBounds = true
  }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        //터치하면 실행
        //한손으로 터치할 수도 있지만 여러 손가락으로 동시에 터치할 수도 있기 때문에 첫번째로 터치한 것인지 아닌지 구분해주어야 함.
        guard let touch = touches.first else { return }
        //touch한 곳의 location정보를 가져 올 것인데 기준(in)을 touch를 한 view를 기준으로 하겠다는 것
        let touchPoint = touch.location(in: touch.view)
        print(touchPoint)
        
        if imageView.frame.contains(touchPoint){
            imageView.image = UIImage(named: "cat2")
            self.lastTouchPoint = touchPoint
            self.isHolidingImage = true
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        //드래깅중에 실행
        guard isHolidingImage, let touch = touches.first else { return }
        let touchPoint = touch.location(in: touch.view)
        
        //클릭 지점(lastTouchPoint)을 기준으로 touchPoint가 움직인 만큼 이미지 center를 움직이라는 것.
        imageView.center.x = imageView.center.x + (touchPoint.x - lastTouchPoint.x)
        imageView.center.y = imageView.center.y + (touchPoint.y - lastTouchPoint.y)
        self.lastTouchPoint = touchPoint
        
        /*아래와 같이 구현하면 lastPoint같은거 구현 따로 안해줘도 됨.
        let previousTouchPoint = touch.previousLocation(in: touch.view)
        imageView.center.x += (touchPoint.x - previousTouchPoint.x)
        imageView.center.y += (touchPoint.y - previousTouchPoint.y)*/
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        //터치가 끝날때 실행
        imageView.image = UIImage(named: "cat1")
        self.isHolidingImage = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        //터치실행 중 갑작스럽게 전화가 오는 등 취소가 되는 경우 실행
        //touchesEnded의 코드를 포함해야 함.
        imageView.image = UIImage(named: "cat1")
        self.isHolidingImage = false
    }
}



