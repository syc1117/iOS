
import UIKit
import RxSwift

/*:
 # ignoreElements
 */

let disposeBag = DisposeBag()
let fruits = ["🍏", "🍎", "🍋", "🍓", "🍇"]



Observable.from(fruits)
    .ignoreElements() // observable이 제대로 방출하는지 여부만 체크하여 copleted 혹은 error여부만 리턴함. 그리고 뒤에 subscribe는 실행되지 않음.
    .subscribe {print($0)}
    .disposed(by: disposeBag)











