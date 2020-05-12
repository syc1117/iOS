

import UIKit
import RxSwift
import RxCocoa

class RxCocoaGestureViewController: UIViewController {
   
   let bag = DisposeBag()
   
   @IBOutlet weak var targetView: UIView!
   
   @IBOutlet var panGesture: UIPanGestureRecognizer!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      targetView.center = view.center
      
    panGesture.rx.event
        .subscribe(onNext: {
            gesture in
            
            guard let target = gesture.view else { return }
            let translation = gesture.translation(in: self.view)
            
            target.center.x += translation.x
            target.center.y += translation.y
            
            gesture.setTranslation(.zero, in: self.view)
            
        })
    .disposed(by: bag)
      
   }   
}
