

import UIKit
import RxSwift

/*:
 # concat
 */
//두개의 obsevable을 연결할 때 사용
//***중요: merge와 달리, 선행된 observable이 complete을 리턴해야 다음 observable이 실행이 됨. merge는 아예 하나로 병합한 후 방출함.
let bag = DisposeBag()
let fruits = Observable.from(["🍏", "🍎", "🥝", "🍑", "🍋", "🍉"])
let animals = Observable.from(["🐶", "🐱", "🐹", "🐼", "🐯", "🐵"])


//타입메서드 방식: collection들을 순서대로 연결한 새로운 obsevable을 생성후에 사용
Observable.concat([fruits, animals])
    .subscribe{ print($0) }
    .disposed(by: bag)

//인스턴스메서드 방식: 앞의 obsevable을 실행한 후 completed가 되면 concat으로 추가한 collection을 실행.
//아래의 예에서 fruits가 error를 내면 concat으로 추가한 animals는 실행되지 않음.
fruits.concat(animals)
    .subscribe{ print($0) }
    .disposed(by: bag)

