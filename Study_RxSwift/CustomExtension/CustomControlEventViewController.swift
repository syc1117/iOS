

import UIKit
import RxSwift
import RxCocoa

class CustomControlEventViewController: UIViewController {
   
   let bag = DisposeBag()
   
   @IBOutlet weak var inputField: UITextField!
   
   @IBOutlet weak var countLabel: UILabel!
   
   @IBOutlet weak var doneButton: UIButton!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      inputField.borderStyle = .none
      inputField.layer.borderWidth = 3
      inputField.layer.borderColor = UIColor.gray.cgColor
      
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: inputField.frame.height))
      inputField.leftView = paddingView
      inputField.leftViewMode = .always
      
//      inputField.rx.text
//         .map { $0?.count ?? 0 }
//         .map { "\($0)" }
//         .bind(to: countLabel.rx.text)
//         .disposed(by: bag)
//
      doneButton.rx.tap
         .subscribe(onNext: { [weak self] _ in
            self?.inputField.resignFirstResponder()
         })
         .disposed(by: bag)
      
//      inputField.delegate = self
    
    //custom control event + custom binder 사용
    inputField.rx.editDidBegin
        .map{ UIColor.red }
        .bind(to: inputField.rx.borderColor)
    .disposed(by: bag)
    
    inputField.rx.editDidEnd
        .map{ UIColor.gray }
        .bind(to: inputField.rx.borderColor)
    .disposed(by: bag)
    
    inputField.rx.text
        .bind(to: countLabel.rx.countStr)
        .disposed(by: bag)
   }
}

extension Reactive where Base: UILabel {
    var countStr: Binder<String?> {
        return Binder(self.base) { base, str in
            let count = str?.count
            base.text = String(count ?? 0)
        }
    }
}

extension Reactive where Base: UITextField {
    //UIColor를 받아서 borderColor에 넣어주는 custom binder 생성
    var borderColor: Binder<UIColor?> {
        return Binder(self.base) { base, color in
            base.layer.borderColor = color?.cgColor
        }
    }
    
    //editingDidBegin로 ControlEvent 추가
    var editDidBegin: ControlEvent<Void>{
        return controlEvent(.editingDidBegin)
    }
    //editingDidEnd로 ControlEvent 추가
    var editDidEnd: ControlEvent<Void> {
        return controlEvent(.editingDidEnd)
    }
}

//extension CustomControlEventViewController: UITextFieldDelegate {
//   func textFieldDidBeginEditing(_ textField: UITextField) {
//      textField.layer.borderColor = UIColor.red.cgColor
//   }
//
//   func textFieldDidEndEditing(_ textField: UITextField) {
//      textField.layer.borderColor = UIColor.gray.cgColor
//   }
//}


