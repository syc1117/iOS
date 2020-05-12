//: [Previous](@previous)



import UIKit
import RxSwift

/*:
 # throttle
 ## latest parameter
 */
/* throttle의 두번째 parameter "latest"에 전달 된 값이 true(생략시  기본값)일때와 false 일때의 작동 차이
 1. latest: true
   - 입력한 주기를 기준으로 바로 직전 혹은 그 때에 방출된 요소를 구독자에게 전달
   - 아래의 예에서, 1초 마다 0~9까지 방출하는 obsever에 2.5초의 true throttle연산자를 추가할 경우, 2.5초가 지난 시점에서 가장 마지막에 전될 되었던 2가 구독자로 전달.
   - 중요: 5초가 지난 시점에 5를 인쇄. 즉, 2.5초에 딱 맞게 방출된 것도 전달.
 2. latest: false
   - 입력한 주기를 기준으로 바로 직후에 방출된 요소를 구독자에게 전달
   - latest: true와 달리, 2.5초가 지난 시점에서 대기하였다가 2.5초 이후 가장 먼저 방출된 3이 구독자로 전달됨.
   - 중요: 5초가 지난 시점에 5를 인쇄하지 않고 6을 인쇄. 즉, 2.5초에 딱 맞게 방출된 것은 전달하지 않고 무조건 그 이후에 처음으로 방출된 것만 전달.
 */
let disposeBag = DisposeBag()

func currentTimeString() -> String {
   let f = DateFormatter()
   f.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
   return f.string(from: Date())
}


Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
   .debug()
   .take(10)
   .throttle(.milliseconds(2500), latest: true, scheduler: MainScheduler.instance)
   .subscribe { print("true",currentTimeString(), $0) }
   .disposed(by: disposeBag)


Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
   .debug()
   .take(10)
   .throttle(.milliseconds(2500), latest: false, scheduler: MainScheduler.instance)
   .subscribe { print("false",currentTimeString(), $0) }
   .disposed(by: disposeBag)
 
