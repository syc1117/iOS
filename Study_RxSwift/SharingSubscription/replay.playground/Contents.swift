
import UIKit
import RxSwift

/*:
 # replay, replayAll
  1) replay: ReplaySubject를 multicast(subject)로 전달한 것과 같음.
  2) 버퍼에 bufferSize 갯수 만큼 요소를 저장해두었다가 sequence에 참여한 구독자들에게 누락없이 모든 값을 전달해줌.
  2. replayAll: bufferSize가 무한으로 설정되기 때문에 특별한 이유가 없으면 사용하지 않는 것이 좋음.
 */

let bag = DisposeBag()
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).take(5).replay(5)

source
   .subscribe { print("🔵", $0) }
   .disposed(by: bag)

// delaySubscription은 사실 3초 뒤부터 방출된 값을 구독해야하는데 ReplaySubject가 모든 값을 버퍼에 저장해두었다가 3초뒤에 이전 것 까지 모두 전달하여 2가 인쇄되는 시점에 0과 1까지 함께 한 번에 인쇄됨.
source
   .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
   .subscribe { print("🔴", $0) }
   .disposed(by: bag)

source.connect()

