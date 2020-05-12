
import UIKit
import RxSwift
import RxCocoa

/*:
 # Relay
 */
/*Relay: RXSwift는 subject를 wrapping하고 있는 두가지 relay를 제공함. relay는 completed, error이벤트는 받지 않고 next이벤트만 받음. 주로 종료없이 계속 전달되는 이벤트 시퀀스를 처리할 때 사용.
- PublishRelay: publishSubject를 wrapping
- BehaviorRelay: behaviorSubject를 wrapping
- 구독자가 종료되기 전까지 종료되지 않음.
- 주로, UI이벤트를 처리할 때 사용.
*/
//*******중요: Relay는 RxCocoa를 import해야 구현됨.

let bag = DisposeBag()

let publishRelay = PublishRelay<Int>()

publishRelay.subscribe {
    print("publishRelay",$0)
}.disposed(by: bag)

publishRelay.accept(1)

let behaviorRelay = BehaviorRelay<Int>(value: 0)

behaviorRelay.subscribe {
    print("behaviorRelay",$0)
}.disposed(by: bag)

behaviorRelay.accept(1)
behaviorRelay.accept(2)
behaviorRelay.accept(3)


print(behaviorRelay.value)
