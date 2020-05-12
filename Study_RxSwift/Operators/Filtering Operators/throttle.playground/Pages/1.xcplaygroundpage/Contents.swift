
import UIKit
import RxSwift

/*:
 # throttle
 */
//지정된 주기마다 구독자에게 요소를 하나씩 전달.
//아래 예에서는 obsevable이 0.3초,0.5초 마다 요소를 방출하지만 throttle에서 주기를 1초로 지정했기때문에, 1초 간격 사이에 방출된 요소들은 구독자에게 전달되지 않고 1초를 주기로 방출된 값들만 구독자에게 전달됨. 단 정확하게 1초 주기에 해당하는 게 없으면 1초가 지난 시점에서 가장 최근 값, 즉, 1초가 지나기 전 가장 마지막 값이 인쇄가 됨.
let disposeBag = DisposeBag()

let buttonTap = Observable<String>.create { observer in
   DispatchQueue.global().async {
      for i in 1...10 {
         observer.onNext("Tap \(i)")
        Thread.sleep(forTimeInterval: 0.5)
      }
      
      Thread.sleep(forTimeInterval: 1)
      
      for i in 11...20 {
         observer.onNext("Tap \(i)")
         Thread.sleep(forTimeInterval: 0.5)
      }
      
      observer.onCompleted()
   }
   
   return Disposables.create()
}


buttonTap.debug()
    .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
    .subscribe { print($0) }
    .disposed(by: disposeBag)

//: [Next](@next)
