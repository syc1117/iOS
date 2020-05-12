
import UIKit
import RxSwift

/*:
 # delaySubscription
 */

let bag = DisposeBag()

func currentTimeString() -> String {
   let f = DateFormatter()
   f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
   return f.string(from: Date())
}

//delay와 결과는 같지만, 작동원리가 다름. delay는 방출은 바로되고 구독자로 전달되는 시점을 지연시키지만, delaySubscription은 방출자체를 지연시킴. 구독과는 지연시간이 없음.
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
.take(10)
.debug()
    .delaySubscription(.seconds(7), scheduler: MainScheduler.instance)
.subscribe{ print(currentTimeString(), $0) }
.disposed(by: bag)

