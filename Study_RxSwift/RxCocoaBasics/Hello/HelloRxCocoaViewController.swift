

import UIKit
import RxSwift
import RxCocoa

class HelloRxCocoaViewController: UIViewController {
   
   let bag = DisposeBag()
   
   @IBOutlet weak var valueLabel: UILabel!
   
   @IBOutlet weak var tapButton: UIButton!
   
   override func viewDidLoad() {
      super.viewDidLoad()
    tapButton.rx.tap //tap: addTarget 과 같음.
        .map {"hello, RxSwift"} // 전달할 값
        .bind(to: valueLabel.rx.text) // map에서 전달된 값을 받을 객체
        .disposed(by: bag)
    
   }
}
