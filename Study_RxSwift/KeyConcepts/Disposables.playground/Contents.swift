

import UIKit
import RxSwift

/*:
 # Disposables
 */
var bag = DisposeBag()

//Observable 선언
let subscription = Observable.from([1,2,3])

//Observable 구독
subscription.subscribe(onNext: {
    print($0)
    }).disposed(by: bag)

//subscription을 DisposeBag에 담기


//DisposeBag 에 담긴 모든 subscription들 해제
//***중요: 옵저버가 이벤트를 모두 실행하고 나면 completion 혹은 error가 자동 호출되면서 dispose역시 자동으로 됨. 그러나 공식 문서에서 수동으로 한 번 더 dispose를 실행하는 것을 권장하기 때문에 아래와 같은 작업을 해야 함.
bag = DisposeBag()

//1초 마다 1씩 숫자가 증가되며 인쇄되는 Observable
let subscription2 = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).subscribe(onNext: { elem in
    print(elem)
}, onError: { error in
    print(error)
}, onCompleted: {
    print("completed")
}) {
    print("Disposed")
}

// 3초후 강제 dispose ******* 중요: 아래와 같이 직접적으로 dispose할 경우 completion과 error 핸들러가 호출되지 않기 때문에 이런 방식은 좋지 않음.
DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    subscription2.dispose()
}








