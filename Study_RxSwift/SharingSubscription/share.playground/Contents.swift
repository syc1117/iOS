import UIKit
import RxSwift

/*:
 # share: 기본적으로 refCount이며, param값에 따라 작동방식이 달라짐.
   - param1: replay(Int)로 기본값 0을 가지며, multicast(PublishSubject)로 간주함. 0 외의 값이 설정되면 multicast(ReplaySubject)로 간주하고 들어간 Int값을 bufferSize로 책정함.
   - param2: scope은 .whileConnected(기본값)와 .forever 두 가지 값을 가지며,
     .whileConnected 는 connect가 새로 될때마다 새로운 subject를 생성하여 사용. .forever는 한 서브젝트를 사용
  1) share(): replay 0, scope .whileConnected 상태로 multicast(PublishSubject)이기 때문에, 구독 이후에 방출된 값들만 구독되고 연결이 새로 될때마다 새로운 subject 생성
     - 아래 결과:
       0, 1, 2, 3, 4
                3, 4
                        0, 1, 2
 
  2) share(replay: 5): multicast(ReplaySubject)로 bufferSize는 5
    - 아래 결과:
          0, 1, 2, 3, 4
                   3(0,1,2), 4  -- 3인쇄될 때 0,1,2모두 인쇄
                           0, 1, 2
 
  3) share(replay: 5, scope: .forever)
    - forever가되면서 한 subject를 공유 하기 때문에 isConnected되었다가 다시 Connected되었을 때 이전에 방출했던 값들을 모두 전달하면서 새로 시작함.
    - 아래 결과:
        0, 1, 2, 3, 4
                 3(0,1,2), 4  -- 3인쇄될 때 0,1,2모두 인쇄
                         (0,1,2,3,4)0, 1, 2 -- 인쇄 시작전에 앞에서 방출되었던것을 먼저 방출하고 다시 시작함.
 */

let bag = DisposeBag()
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).debug().share(replay: 3, scope: .forever)

let observer1 = source
   .subscribe { print("🔵", $0) }

let observer2 = source
   .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
   .subscribe { print("🔴", $0) }

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
   observer1.dispose()
   observer2.dispose()
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
   let observer3 = source.subscribe { print("⚫️", $0) }

   DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      observer3.dispose()
   }
}
