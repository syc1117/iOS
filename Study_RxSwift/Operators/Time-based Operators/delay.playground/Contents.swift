

import UIKit
import RxSwift

/*:
 # delay
 */
//delay: 방출된 값을 원하는 시간만큼 지연시켜서 구독자에게 전달하는 연산자
let bag = DisposeBag()

func currentTimeString() -> String {
    let f = DateFormatter()
    f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return f.string(from: Date())
}
//1초 마다 0부터 10개 방출. 그러나 delay연산자에 의해서 5초 후부터 구독자에 전달됨.
Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .take(10)
    .debug()
    .delay(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe{ print(currentTimeString(), $0) }
    .disposed(by: bag)
