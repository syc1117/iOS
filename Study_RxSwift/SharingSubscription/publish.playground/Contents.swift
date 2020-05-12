 
import UIKit
import RxSwift

/*:
 # publish
  1) multicast에서 subject로 publishSubject를 사용할 경우 이 연산자를 사용하면 보다 간편함.
  2) 별도의 publishSubject를 생성할 필요 없이 multicast(subject)를  publish()로 대체할 수 있음.
 */

let bag = DisposeBag()

let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).take(5).publish()

source
   .subscribe { print("🔵", $0) }
   .disposed(by: bag)

source
   .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
   .subscribe { print("🔴", $0) }
   .disposed(by: bag)

source.connect()






