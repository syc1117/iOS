

import UIKit
import RxSwift
import RxCocoa

class CustomBinderViewController: UIViewController {
   
   let bag = DisposeBag()
   
   @IBOutlet weak var valueLabel: UILabel!
   
   @IBOutlet weak var colorPicker: UISegmentedControl!
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
    colorPicker.rx.selectedSegmentIndex
        .subscribe(onNext: {[weak self] index in
            switch index {
            case 0:
                self?.valueLabel.textColor = .red
                self?.valueLabel.text = "Red"
            case 1:
              self?.valueLabel.textColor = .green
                self?.valueLabel.text = "green"
            case 2:
              self?.valueLabel.textColor = .blue
                self?.valueLabel.text = "blue"
            default:
              self?.valueLabel.textColor = .black
                self?.valueLabel.text = "black"
            }
        })
        .disposed(by: bag)
      
//      colorPicker.rx.selectedSegmentIndex
//         .map { index -> UIColor in
//            switch index {
//            case 0:
//               return UIColor.red
//            case 1:
//               return UIColor.green
//            case 2:
//               return UIColor.blue
//            default:
//               return UIColor.black
//            }
//         }
//         .subscribe(onNext: { [weak self] color in
//            self?.valueLabel.textColor = color
//         })
//         .disposed(by: bag)
//
//      colorPicker.rx.selectedSegmentIndex
//         .map { index -> String? in
//            switch index {
//            case 0:
//               return "Red"
//            case 1:
//               return "Green"
//            case 2:
//               return "Blue"
//            default:
//               return "Unknown"
//            }
//         }
//         .bind(to: valueLabel.rx.text)
//         .disposed(by: bag)
//
    //custom binder 사용하기: segmentedValue
    colorPicker.rx.selectedSegmentIndex
        .bind(to: valueLabel.rx.segmentedValue) // segmentedValue는 extention으로 새로 만든 custom binder
    .disposed(by: bag)
   }
}

//custom Binder 생성하기:UISegmentedControl 에서 전달되는 index를 받아 index값에 따라 label의 색상과 text를 변환
extension Reactive where Base: UILabel {
    // Binder<Int>: bind to를 통해 넘겨 받을 값의 타입이 Int라는 것. 여기서는 UISegmentedControl의 index를 받기 때문.
    var segmentedValue: Binder<Int> {
        //Binder(self.base): 첫번째 parameter로 UIlabel을 전달하고 있다는 뜻.
        //두 번째 param인 MainScheduler는 생략
        //세 번째 param은 trailing closure로 전달. { lable, index in ... }, index는 binder를 통해 전달된 값을 의미함. 여기서는 UISegmentedControl의 index를 받을 것임.
        return Binder(self.base) { lable, index in
            switch index {
            case 0:
                lable.text = "Red"
                lable.textColor = .red
                
            case 1:
                lable.text = "Green"
                lable.textColor = .green
                
            case 2:
                lable.text = "Blue"
                lable.textColor = .blue
                
            default:
                lable.text = "black"
                lable.textColor = .black
            }
        }
    }
}

