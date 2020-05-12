
import UIKit
import RxSwift

/*:
 # deferred: 특정 조건으로 obsevable 생성할 때 사용
 */

let disposeBag = DisposeBag()
let animals = ["🐶", "🐱", "🐹", "🐰", "🦊", "🐻", "🐯"]
let fruits = ["🍎", "🍐", "🍋", "🍇", "🍈", "🍓", "🍑"]
var flag = true

let factory: Observable<String> = Observable.deferred{
    flag.toggle()
    
    if flag {
        return Observable.from(animals)
    } else {
        return Observable.from(fruits)
    }
}

factory.subscribe{
    print($0)
}

factory.subscribe{
    print($0)
}




