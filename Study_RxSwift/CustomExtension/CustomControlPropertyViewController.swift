
import UIKit
import RxSwift
import RxCocoa

class CustomControlPropertyViewController: UIViewController {
    
    let bag = DisposeBag()
    
    @IBOutlet weak var resetButton: UIBarButtonItem!
    
    @IBOutlet weak var whiteSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //whiteSlider.rx.value는 control Property로 되어있기 때문에 값을 방출하는 observable로도 사용가능하고 값을 받는(binding되는) observer로도 사용 가능함.
        //slider의 value는 user-interactive를 통해 변경된 값을 가지기도 하고 코드에서 값을 넣어 변경할 수도 있음. 이러한 특성 때문에 control Property를 사용하는 것임.
        whiteSlider.rx.value
            .map { UIColor(white: CGFloat($0), alpha: 1.0) }
            .bind(to: view.rx.backgroundColor)
            .disposed(by: bag)
        
        resetButton.rx.tap
            .map { Float(0.5) }
            .bind(to: whiteSlider.rx.value)
            .disposed(by: bag)
        
        resetButton.rx.tap
            .map { UIColor(white: 0.5, alpha: 1.0) }
            .bind(to: view.rx.backgroundColor)
            .disposed(by: bag)
        
        
        whiteSlider.rx.changeColor
            .bind(to: view.rx.backgroundColor)
            .disposed(by: bag)
        
        resetButton.rx.tap
            .map{ _ in UIColor(white: 0.5, alpha: 0.5) }
            .bind(to: whiteSlider.rx.changeColor.asObserver(),
                  view.rx.backgroundColor.asObserver())
            .disposed(by: bag)
        
    }
}

extension Reactive where Base: UISlider {
    var changeColor: ControlProperty<UIColor?> {
        return base.rx.controlProperty(editingEvents: .valueChanged,
            //읽기: slider의 값이 변하면 들어오는 값을 읽어서 무언가 할 때 사용
            getter: { base in
                UIColor(white: CGFloat(base.value), alpha: 1.0)
        },  //쓰기: slider의 값을 지정할 때 사용. 여기서 base는 slider를 의미하며, color는 ControlProperty<UIColor?>에서 UIColor를 받기로 했기 때문에 UIColor를 의미함. bind를 통해 전달받을 값의 타입을 의미.
            setter: { base, color in
                var white = CGFloat(1)
                color?.getWhite(&white, alpha: nil)
                base.value = Float(white)
        })
    }
}
