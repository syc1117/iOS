

import UIKit
import RxSwift

/*:
 # generate
 */

let disposeBag = DisposeBag()
let red = "🔴"
let blue = "🔵"

//0부터 10이 되기전까지 2씩 증가하는 함수
Observable.generate(initialState: 0/*시작값*/, condition: { $0 <= 10 /*Bool, 참 일때만 실행*/},  iterate: { $0 + 2 /*증가 형식*/ }).subscribe{ print($0) }.disposed(by: disposeBag)


Observable.generate(initialState: red, condition: { $0.count < 15 }, iterate: { $0.count.isMultiple(of: 2) ? $0 + red : $0 + blue }).subscribe{ print($0) }.disposed(by: disposeBag)





