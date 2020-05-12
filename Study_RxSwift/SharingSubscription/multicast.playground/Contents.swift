
import UIKit
import RxSwift

/*:
 # multicast:
   1) 하나의 obsevable에 대해서 여러 구독자가 구독을 할 때, 원래는 완전히 독립된 작업을 수행하면서 각각의 sequence를 생성하지만, multicast를 사용하게 되면 .connect()된 시저부터 obsevable이 방출을 시작하고 그 sequence를 함께 공유하여 결과적으로 한 개의 sequence로 구독자들이 작업을 수행하게 됨.
   2) 번거로워서 잘 안씀. multicast를 구현해 놓은 다른 연산자를 많이 사용함.
   3) 구독자 각자가 각자의 sequence를 생성하여 사용하지 않고 한개의 sequence를 쓴다는 것이 핵심.
 */

let bag = DisposeBag()
let subject = PublishSubject<Int>()
//multicast(subject)에 Observable이 저장 되었다가, soure.connect가 읽힌 시점에서 source가 방출과 구독을 시작함.
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).take(5).multicast(subject)

source
   .subscribe { print("🔵", $0) }
   .disposed(by: bag)

//source.connect()을 시작한 시점부터 이미 source는 방출을 시작하고 아래 구독자는 3초의 지연시간을 두고 sequence에 참여하기때문에 원래 "3초 후부터 0 ~ 4까지 인쇄"해야하는 작업이지만 "3초 후부터 2~4까지 인쇄"하고 종료됨. 이미 source는 방출을 시작했고 아래 구독자는 3초후에 참여한 결과임.
source
   .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
   .subscribe { print("🔴", $0) }
   .disposed(by: bag)

source.connect()







