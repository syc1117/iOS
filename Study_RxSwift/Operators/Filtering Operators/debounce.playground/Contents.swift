
import UIKit
import RxSwift

/*:
 # debounce
 */
//사용예시: 검색기능. 문자열을 입력할때마다 검색을하지 않고 문자열을 다 입력한 시점에 검색을 실행할 수 있도록 할 때 사용.
let disposeBag = DisposeBag()

let buttonTap = Observable<String>.create { observer in
   DispatchQueue.global().async {
      for i in 1...10 {
         observer.onNext("Tap \(i)")
         Thread.sleep(forTimeInterval: 0.3)
      }
      
      Thread.sleep(forTimeInterval: 1)
      
      for i in 11...20 {
         observer.onNext("Tap \(i)")
         Thread.sleep(forTimeInterval: 0.5)
      }
      
      observer.onCompleted()
   }
   
   return Disposables.create {
      
   }
}
//.milliseconds(1000) - 1초 안에 방출되는 것들은 모두 무시하고 1초가 지났을때 마지막에 방출된 것을 구독자에 전달.
buttonTap
    .debounce(.milliseconds(1000), scheduler: MainScheduler.instance)
   .subscribe { print($0) } // 10과 20, 2개만 구독
   .disposed(by: disposeBag)


