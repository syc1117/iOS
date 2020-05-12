
import UIKit
import RxSwift

/*:
 # retry: error가 발생하면 구독을 재시도
 1) retry() : observable이 completed를 리턴할 때까지 계속 반복. 그러나 무한루프가 발생하여 터치이벤트가 안먹히거나 앱이 죽을 수도 있기 때문에 사용을 피해야 함.
 2) .retry(Int): 재시도 회수를 설정할 수 있음. int은 총 시도 횟수이므로 6번 재시도 하고 싶다면 7을 입력해야함. 또한, 7번을 시도하라고 하더라도 그 안에 조건을 만족하면 빨리 completed될 수 있음.
 */

let bag = DisposeBag()

enum MyError: Error {
    case error
}

var attempts = 1

let source = Observable<Int>.create { observer in
    let currentAttempts = attempts
    print("#\(currentAttempts) START")
    
    if attempts < 3 {
        observer.onError(MyError.error)
        attempts += 1
    }
    
    observer.onNext(1)
    observer.onNext(2)
    observer.onCompleted()
    
    return Disposables.create {
        print("#\(currentAttempts) END")
    }
}

source
    .retry(6)
    .subscribe { print($0) }
    .disposed(by: bag)
