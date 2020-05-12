
import UIKit
import RxSwift
import RxCocoa

enum ValidationError: Error {
   case notANumber
}

class DriverViewController: UIViewController {
   
   let bag = DisposeBag()
   
   @IBOutlet weak var inputField: UITextField!
   
   @IBOutlet weak var resultLabel: UILabel!
   
   @IBOutlet weak var sendButton: UIButton!
   
   override func viewDidLoad() {
      super.viewDidLoad()
    
    //bind를 사용하는 경우와 Drive를 사용하는 경우 구분: bind는 단일 객체 - 단일 observable을 사용하는 경우, Drive는 하나의 observable을 여러 객체가 bind해서 사용하는 경우 중복 작업을 제거하기 위해 사용.
      
    let result = inputField.rx.text.asDriver() //share() + errorHandler-catchErrorJustReturn 기능 탑재
        .flatMapLatest { validateText($0).asDriver(onErrorJustReturn: false) }
    // result를 3번 호출하였지만 Driver를 통해 하나의 시퀸스만 사용
      result
         .map { $0 ? "Ok" : "Error" }
         .drive(resultLabel.rx.text) // asDriver()를 사용하면 bind(to:) 대신 drive 사용
         .disposed(by: bag)

      result
         .map { $0 ? UIColor.blue : UIColor.red }
         .drive(resultLabel.rx.backgroundColor)
         .disposed(by: bag)

      result
         .drive(sendButton.rx.isEnabled)
         .disposed(by: bag)
      
   }
}


func validateText(_ value: String?) -> Observable<Bool> {
   return Observable<Bool>.create { observer in
      print("== \(value ?? "") Sequence Start ==")
      
      defer {
         print("== \(value ?? "") Sequence End ==")
      }
      
      guard let str = value, let _ = Double(str) else {
         observer.onError(ValidationError.notANumber)
         return Disposables.create()
      }
      
      observer.onNext(true)
      observer.onCompleted()
      
      return Disposables.create()
   }
}
