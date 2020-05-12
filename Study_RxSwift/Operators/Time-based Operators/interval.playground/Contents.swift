

import UIKit
import RxSwift

/*:
 # interval
 */
//.seconds(Int)주기로 1씩 증가하는 요소 방출. 자체적으로는 멈출 수 없어서 DispatchQueue.main.asyncAfter로 원하는 시간 후에 멈춰주어야 함.
let i = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)

let subscription1 = i.subscribe{print("1>>>>\($0)")}

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    subscription1.dispose()
}

var subscription2: Disposable?

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    subscription2 = i.subscribe{print("2>>>>\($0)")}
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    subscription2?.dispose()
}
