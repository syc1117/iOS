
import UIKit
import RxSwift

/*:
 # Scheduler: GCD의 개념
   1) MainQueue = MainScheduler
   2) GlobalQueue = BackgroundScheduler
   3) 명령어
     - subscribeOn: observable 자체가 실행될 thread 지정(코드 작성 위치 무관)
     - observeOn: observable의 연산자들이 실행될 thread 지정
 */

let bag = DisposeBag()
let backgroundScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())

Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
.subscribeOn(backgroundScheduler) // Observable 자체의 thread결정
   .filter { num -> Bool in
      print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> filter")
      return num.isMultiple(of: 2)
   }
.observeOn(MainScheduler.instance) // 아래 모든 연산자들이 thread 지정
   .map { num -> Int in
      print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> map")
      return num * 2
}.subscribe{
    print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> subscribe")
    print($0)
}.disposed(by: bag)





