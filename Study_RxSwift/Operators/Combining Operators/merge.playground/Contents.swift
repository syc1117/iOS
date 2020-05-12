
import UIKit
import RxSwift

/*:
 # merge
 */
//merge: 여러개의 observable을 하나로 합쳐서 방출.
//***중요: concat과 결과가 유사하게 나올 수 있으나 concat은 합치는 것이 아니고 연결해서 순서대로 실행시키는 것임. 선행되는 obsevable이 error을 리턴하면 뒤의 것은 실행되지 않음.
let bag = DisposeBag()

enum MyError: Error {
   case error
}

let oddNumbers = BehaviorSubject(value: 1)
let evenNumbers = BehaviorSubject(value: 2)
let negativeNumbers = BehaviorSubject(value: -1)

let source = Observable.of(oddNumbers,evenNumbers)

let source2 = Observable.of(oddNumbers, evenNumbers, negativeNumbers )

oddNumbers.onNext(3)
evenNumbers.onNext(4)

source.merge()
    .subscribe{ print($0) }
    .disposed(by: bag)

//oddNumbers에 onCompleted 이벤트를 전달해도 evenNumbers는 작동함. 그러나 onError가 전달되면 둘다 작동되지 않음.
//oddNumbers.onCompleted()
evenNumbers.onNext(5)

print("=====source2=====")
source2.merge(maxConcurrent: 2) // 병합대상을 2개로 제한하고 싶을 때 사용.
.subscribe{ print($0) }
.disposed(by: bag)

evenNumbers.onNext(6)
oddNumbers.onNext(7)
negativeNumbers.onNext(-1) // maxConcurrent로 merge가능 갯 수를 2개로 제한해 놓아서 실행되지 않다가 밑에서 evenNumbers가 completed되는 순간 실행됨.

evenNumbers.onCompleted()


