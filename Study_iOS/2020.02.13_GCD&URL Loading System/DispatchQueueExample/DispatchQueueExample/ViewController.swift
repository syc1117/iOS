//
//  ViewController.swift
//  DispatchQueueExample
//
//  Created by giftbot on 2020. 2. 12..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
  @IBOutlet private weak var testView: UIView!

  @IBAction private func buttonDidTap(_ sender: Any) {
    print("---------- [ Change Color ] ----------\n")
    let r = CGFloat.random(in: 0...1.0)
    let g = CGFloat.random(in: 0...1.0)
    let b = CGFloat.random(in: 0...1.0)
    testView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
  }

  func bigTask() {
    print("= Big task start =")
    for _ in 0...5_000_000 { _ = 1 + 1 } // 1+1 을 500만번 반복시키는 내용
    print("= Big task end =")
  }
  
  @IBAction func bigTaskOnMainThread() {
    
    bigTask()
    //serial Que
    //일반적으로 별 명시 없이 그냥 실행하면 모두 sync로 실행됨(순서대로 실행된다는 것)
  }
  
  
  @IBAction func uiTaskOnBackgroundThread() {
    print("\n---------- [ uiTaskOnBackgroundThread ] ----------\n")
    
    DispatchQueue.global().async {
      self.bigTask()
        //bigTask가 실행이 완료된 다음 아래 buttonDidTap를 실행함.
        //bigTask가 실행중이어도 앱의 다른 기능등을 사용할 수 있게 하기 위해서 global로 할당
        //qos를 따로 지정하지않으면 .default를 기본값으로 채택함.
        DispatchQueue.main.async {
             self.buttonDidTap(self) // 버튼 생성해 놓은 것 자동 실행시키는 방법
            //buttonDidTap은 색상 변경 함수로 UI와 관련된 것이기 때문에 main에 작업을 할당해주어야 함. global Que에 놔둘 경우에는 작업 시점을 가늠할 수 없고 동시에 다른 작업과 충돌이 나서 앱이 죽는 경우도 발생할 수 있기때문임.
        }
    }
  }
  
  
  func log(_ str: String) {
    print(str, terminator: " - ")
  }
  /*학습목표
     1. serial Que의 sync, async의 차이를 설명할 수 있다.
     2. 아래 코드에서 serialSyncOrder와 serialAsyncOrder를 눌렀을 때 나타나는 결과를 예측 할 수 있다.
     3. 위의 결과를 컴퓨터의 연산작용 순서를 통해 설명할 수 있다.
     */
  @IBAction private func serialSyncOrder(_ sender: UIButton) {
    print("\n---------- [ Serial Sync ] ----------\n")
    let serialQueue = DispatchQueue(label: "kr.giftbot.serialQueue")
    serialQueue.sync { log("1") }
    log("A")
    serialQueue.sync { log("2") }
    log("B")
    serialQueue.sync { log("3") }
    log("C")
    print()
    
    //작동순서: log("1") 작업 등록 + 실행 종료 -> log("A") 실행 -> log("2") 작업등록 + 실행 종료 -> log("B") 실행
    //컴퓨터 연산 순서: []를 que라고 하면, [1] -> log("A") -> [2] -> log("B") -> [3] -> log("C")
    
  }
  
  @IBAction private func serialAsyncOrder(_ sender: UIButton) {
    print("\n---------- [ Serial Async ] ----------\n")
    let serialQueue = DispatchQueue(label: "kr.giftbot.serialQueue")
    serialQueue.async { self.log("1") }
    log("A")
    serialQueue.async { self.log("2") }
    log("B")
    serialQueue.async { self.log("3") }
    log("C")
    print()
    //작동순서: log("1") 작업 등록 -> log("A") 실행 -> log("2") 작업등록  -> log("B") 실행 -> log("3") 단, 여기서 log 1,2,3이 순서대로 등록되고 순서대로 실행이 되지만 각 등록된 작업이 언제 실행될지는 알 수 없음. 따라서 [1,2,3] 작업은 log("A") log("B") log("C") 사이에 무작위로 끼어 들어 수행하게 됨.
    //컴퓨터 연산 순서: []를 que라고 하면, [1] 등록 -> log("A") -> [1,2]등록 -> log("B") -> [1,2,3]등록 -> log("C")
  }
  
    
    /*학습목표
     1. serial(직렬)과 concurrent(병렬)방식의 각 sync와 async의 차이를 설명할 수 있다.
      1) serial sync VS concurrent sync: 같음
      2) serial async VS concurrent async:
        - serial async: 등록되는 순서가 순차적 but 실행시점은 알 수 없음. 그러나 작업 순서는 코딩한 순서대로 실행
        - concurrent async: 등록된 결과가 순차적이지 않고 실행시점도 알 수 없으며, 따라서 작업 순서는 코딩 순서와 상관없이 랜덤.
     */
  @IBAction private func concurrentSyncOrder(_ sender: UIButton) {
    print("\n---------- [ Concurrent Sync ] ----------\n")
    let concurrentQueue = DispatchQueue(
      label: "kr.giftbot.concurrentQueue",
      attributes: [.concurrent]
    )
    //sync는 serial(직렬)과 concurrent(병렬)과 상관없이 항상 작업방식이 같음.
    concurrentQueue.sync { log("1") }
    log("A")
    concurrentQueue.sync { log("2") }
    log("B")
    concurrentQueue.sync { log("3") }
    log("C")
    print()
    //1 - A - 2 - B - 3 - C 로 항상 동일한 결과가 나옴.
  }
  
   
  @IBAction private func concurrentAsyncOrder(_ sender: UIButton) {
    print("\n---------- [ Concurrent Async ] ----------\n")
    let concurrentQueue = DispatchQueue(
      label: "kr.giftbot.concurrentQueue",
      attributes: [.concurrent]
    )
    concurrentQueue.async { self.log("1") }
    concurrentQueue.async(qos: .userInteractive, execute: { self.log("1") })
    log("A")
    concurrentQueue.async { self.log("2") }
    log("B")
    concurrentQueue.async { self.log("3") }
    log("C")
    concurrentQueue.async { self.log("4") }
    log("D")
    print()
    //A B C D는 순서대로 나오지만 1,2,3,4는 마구 뒤섞여 나옴.
  }
  
  
  
  private func createDispatchWorkItem() -> DispatchWorkItem {
    // 출력 순서
    // 25%, 50% , 75%, 100% 나올때까지 연산돌리는 작업을 미리 할당해 놓고 나중에 불러 쓸 수 있게 하는 것
    let workItem = DispatchWorkItem {
      let bigNumber = 8_000_000
      let divideNumber = 2_000_000
      for i in 1...bigNumber {
        guard i % divideNumber == 0 else { continue }
        print(i / divideNumber * 25, "%")
      }
    }
    return workItem
  }
  
  
  @IBAction func waitWorkItem() {
    print("\n---------- [ waitWorkItem ] ----------\n")
    
    let workItem = createDispatchWorkItem()
    let myQueue = DispatchQueue(label: "kr.giftbot.myQueue")
    
    // async vs sync
    myQueue.async(execute: workItem) // 아래  print("before waiting"), print("after waiting")가 먼저 다 나오고 마지막에 25%, 50% -- 이 실행
//    myQueue.sync(execute: workItem) // 25%, 50% --  실행되고나서 프린트 실행
    
    print("before waiting")
//    workItem.wait() // async를 sync처럼 사용하고 싶을 때 사용. 다 실행할 때 까지 sync처럼 유저가 다른기능 실행하지 못함.
    print("after waiting")
  }
  
  
  let inactiveQueue = DispatchQueue(
    label: "kr.giftbot.inactiveQueue",
    attributes: [.initiallyInactive, .concurrent]
    //initiallyInactive : que에 등록만 해놓고 작업 실행을 보류 시켜놓았다가. .activate()가 입력된 위치에서 작업을 실행하게 하고 싶을 때 사용함.
  )
  
  @IBAction func initiallyInactiveQueue() {
    print("\n---------- [ initiallyInactiveQueue ] ----------\n")

    let workItem = createDispatchWorkItem()
    inactiveQueue.async(execute: workItem)
    
    print("= Do Something... =")
    
    // 필요한 타이밍에 activate 메서드를 통해 활성화
    inactiveQueue.activate() // .activate()가 없으면 workItem 실행안됨. 또한, inactiveQueue.activate() 를 여러개 해놔도 한번만 실행됨. 그 이유는 초반에 작업등록을 하나만 했기 때문에 한번 작업을 빼가고 나면 Que에 작업이 남아있지 않기 때문.
  }
  
  //groupNotify: 여러개의 concurrent 작업이 다 완료된 다음에 특정 명령을 하고 싶을 때 사용. 예를 들어 네트워킹 작업을 여러개 해야하는데 그 작업이 다 끝난 후에야 실행해야할 작업이 있을 때 사용할 수 있음.
  @IBAction func groupNotify() {
    print("\n---------- [ groupNotify ] ----------\n")
    
    let queue1 = DispatchQueue(label: "kr.giftbot.example.queue1",
                               attributes: .concurrent)
    let queue2 = DispatchQueue(label: "kr.giftbot.example.queue2")
    
    func calculate(task: Int, limit: Int) {
      print("Task\(task) 시작")
      for _ in 0...limit { _ = 1 + 1 }
      print("Task\(task) 종료")
    }
    
    let group = DispatchGroup()
    queue1.async(group: group) { calculate(task: 1, limit: 12_000_000) }
    queue1.async(group: group) { calculate(task: 2, limit:  5_000_000) }
    queue2.async(group: group) { calculate(task: 3, limit:  2_000_000) }
    group.notify(queue: .main) { print("작업 완료") }
  }
  
  
  var myWorkItem: DispatchWorkItem!
  //몇 초 안에 작업 완료 안되면 취소하는 방법
  @IBAction func cancelDispatchWorkItem() {
    myWorkItem = DispatchWorkItem {
      let bigNumber = 8_000_000
      let divideNumber = bigNumber / 4
      for i in 1...bigNumber {
        guard i % divideNumber == 0 else { continue }
        print(i / divideNumber * 25, "%")
        guard !self.myWorkItem.isCancelled else { return } // myWorkItem이 cancel되면 return해서 종료시켜라
      }
    }

    DispatchQueue.global().async(execute: myWorkItem)
    
    let timeLimit = 3.0
    DispatchQueue.global().async {
        let timeoutResult = self.myWorkItem.wait(timeout: .now() + timeLimit)
        switch timeoutResult {
        case .success: print("성공")
        case .timedOut: self.myWorkItem.cancel() //이 자체로는 cancel이 되지 않음. 위 myWorkItem 내부 코드에서 cancel되었을 때 어떻게 할지 정해주어야함.
            print("Timed out")
        }
    }
  }
}
