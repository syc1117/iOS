

import UIKit
import RxSwift

/*:
 # map
 */

let disposeBag = DisposeBag()
let skills = ["Swift", "SwiftUI", "RxSwift"]

Observable.from(skills)
    .map{ "Hello, \($0)" }
    .subscribe{ print($0) } // next("Hello,Swift"), next("Hello,SwiftUI"), next("Hello,RxSwift") 인쇄. 3개를 배열로 묶어서 인쇄하는 것 아님. swift의 forEach와 같은 기능.
    .disposed(by: disposeBag)

print("------------------------")

Observable.from(skills)
    .map{ $0.count } // next(5),next(7),next(7) 인쇄.
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

