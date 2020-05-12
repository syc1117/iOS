
import UIKit
import RxSwift

/*:
 # groupBy
 */

let disposeBag = DisposeBag()
let words = ["Apple", "Banana", "Orange", "Book", "City", "Axe"]

Observable.from(words)
    .groupBy{$0.count} // 글자수를 key로 해서 group옵저버블 형성
    .subscribe(onNext: {
        
        print("\($0.key)")
        
        $0.subscribe {
            print("\($0)")
        }
        
})
.disposed(by: disposeBag)
