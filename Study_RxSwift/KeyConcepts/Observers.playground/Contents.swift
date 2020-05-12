
import UIKit
import RxSwift

/*:
 # Observers
 */

// #1

//create 연산자: Observable의 기능을 직접 구현할때 사용. Observable타입 프로토콜에 선언되어 있는 타입 메서드임. Rx에서는 이런 메서드를 연산자라 함.

let o1 = Observable<Int>.create { (observer) -> Disposable in
   observer.on(.next(0)) //next이벤트에 0을 담아서 on 메서드를 통해 전달. 구독자(observer)로 0이 저장되어 있는 next이벤트가 전달됨.
   observer.onNext(1) // 위의 것과 같은 기능임.
   
   observer.onCompleted() // observable 종료. 이 코드 이후에는 이벤트 전달이 안됨.
   
   return Disposables.create() //메모리 관리 객체
}

o1.subscribe { //이 클로져가 observer. 여기로 이벤트가 전달됨.
    print($0)//next(0), next(1) 로 나옴

    if let elem = $0.element { //next를 벗기기 위해서 .element사용
        print(elem)
    }
}

o1.subscribe(onNext: { elem in
    print(elem) //0, 1
                //onNext를 이용해서 .element를 사용하지 않고 바로 안의 값을 가져올 수 있음.
})

// # 2
// #1과 같은 기능. array의 element들을 순서대로 방출하고 completed를 실행하는 obsevable을 생성. 순서대로 방출하는 옵저버블을 만들 때는 creat 보다 from을 사용하는 것이 좋음.
Observable.from([1, 2, 3])

//**Observable을 생성했을 뿐 이벤트가 전달되는 것은 아님. 이벤트 전달은 subscriber에 의해 실행됨.















