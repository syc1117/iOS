

import UIKit
import RxSwift

/*:
 # repeatElement
 */

let disposeBag = DisposeBag()
let element = "❤️"

//repeatElement는 take로 갯수 지정 안해주면 무한반복 되므로 주의필요
Observable.repeatElement(element).take(7).subscribe{print($0)}.disposed(by: disposeBag)







