
import UIKit
import RxSwift
import RxCocoa

class RxCocoaCollectionViewViewController: UIViewController {
   
   let bag = DisposeBag()
   
   @IBOutlet weak var listCollectionView: UICollectionView!
   
    let colorObservable = Observable.of(MaterialBlue.allColors)
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
    colorObservable.bind(to: listCollectionView.rx.items(cellIdentifier: "colorCell", cellType: ColorCollectionViewCell.self)) { index, contents, cell in
        
        cell.backgroundColor = contents
        cell.hexLabel.text = contents.rgbHexString
    }
   .disposed(by: bag)
    
    listCollectionView.rx.modelSelected(UIColor.self)
        .subscribe{
        content in
        print(content)
    }
   .disposed(by: bag)
   
    listCollectionView.rx.setDelegate(self).disposed(by: bag)
   }
}


extension RxCocoaCollectionViewViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
         return CGSize.zero
      }
      
      let value = (collectionView.frame.width - (flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing)) / 2
      return CGSize(width: value, height: value)
   }
}
