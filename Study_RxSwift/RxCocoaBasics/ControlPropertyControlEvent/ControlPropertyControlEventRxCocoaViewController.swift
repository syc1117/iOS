

import UIKit
import RxSwift
import RxCocoa

class ControlPropertyControlEventRxCocoaViewController: UIViewController {
   
   let bag = DisposeBag()
   
   @IBOutlet weak var colorView: UIView!
   
   @IBOutlet weak var redSlider: UISlider!
   @IBOutlet weak var greenSlider: UISlider!
   @IBOutlet weak var blueSlider: UISlider!
   
   @IBOutlet weak var redComponentLabel: UILabel!
   @IBOutlet weak var greenComponentLabel: UILabel!
   @IBOutlet weak var blueComponentLabel: UILabel!
   
   @IBOutlet weak var resetButton: UIButton!
   
   private func updateComponentLabel() {
      redComponentLabel.text = "\(Int(redSlider.value))"
      greenComponentLabel.text = "\(Int(greenSlider.value))"
      blueComponentLabel.text = "\(Int(blueSlider.value))"
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
    
    redSlider.rx.value
        .map{ "\(Int($0))" }
        .bind(to: redComponentLabel.rx.text)
        .disposed(by: bag)
    
    greenSlider.rx.value
    .map{ "\(Int($0))" }
    .bind(to: greenComponentLabel.rx.text)
    .disposed(by: bag)
    
    blueSlider.rx.value
    .map{ "\(Int($0))" }
    .bind(to: blueComponentLabel.rx.text)
    .disposed(by: bag)
    
    Observable.combineLatest(redSlider.rx.value, greenSlider.rx.value, blueSlider.rx.value) { UIColor(red: CGFloat($0) / 255, green: CGFloat($1) / 255, blue: CGFloat($2) / 255, alpha: 1)}
        .bind(to: colorView.rx.backgroundColor)
        .disposed(by: bag)
        
    resetButton.rx.tap
        .subscribe(onNext: { [weak self] in
            self?.colorView.backgroundColor = .black
            
            self?.redSlider.value = 0
            self?.greenSlider.value = 0
            self?.blueSlider.value = 0
            
            self?.updateComponentLabel()
        })
    .disposed(by: bag)
    
    }
    
}
