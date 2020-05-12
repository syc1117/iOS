
import UIKit
import RxSwift

/*:
 # from: 배열에 있는 element들 하나씩 방출
 */

let disposeBag = DisposeBag()
let fruits = ["🍏", "🍎", "🍋", "🍓", "🍇"]

Observable.from(fruits)
   .subscribe { element in print(element) }
   .disposed(by: disposeBag)















