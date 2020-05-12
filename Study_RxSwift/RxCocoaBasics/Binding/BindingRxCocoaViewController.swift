
import UIKit
import RxSwift
import RxCocoa

class BindingRxCocoaViewController: UIViewController {
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var valueField: UITextField!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valueLabel.text = ""
        valueField.becomeFirstResponder()
        // bind를 하기 위해서는 controlProperty를 사용해야하기 때문에, rx.text와 같이 rx.을 사용해야한다.
        //rxcoco가 확장한 text속성은 textField의 값이 업데이트 될때마다 next이벤트를 전달함.
        valueField.rx.text
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] str in
                self?.valueLabel.text = str
            })
            .disposed(by: disposeBag)
        
        //bind가 obsevable이 방출한 값을 observer에 전달. 여기서는 label의 rxcoco가 추가한 text 속성으로 전달됨. rx.text는 binder 형식. 결과적으로 textField의 text와 바인딩 되어 둘이 같은 값을 나타냄.
        //bind는 알아서 mainTread에 할당해주기 때문에 훨씬 편리함.
        valueField.rx.text
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        valueField.resignFirstResponder()
    }
}
