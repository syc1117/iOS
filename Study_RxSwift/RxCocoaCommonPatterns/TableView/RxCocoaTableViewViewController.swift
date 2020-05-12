

import UIKit
import RxSwift
import RxCocoa


class RxCocoaTableViewViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    let priceFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = NumberFormatter.Style.currency
        f.locale = Locale(identifier: "Ko_kr")
        
        return f
    }()
    
    let bag = DisposeBag()
    
    let nameObservable = Observable.of( appleProducts.map{$0.name} )
    let productObservable = Observable.of(appleProducts)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //    //#1
        //    nameLabel.bind(to: listTableView.rx.items) { tableView, row, element in
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "standardCell")!
        //        cell.textLabel?.text = element
        //        return cell
        //    }
        //   .disposed(by: bag)
        //
        //    //#2 : items 생성할 때부터 cell identifier 입력
        //    nameLabel.bind(to: listTableView.rx.items(cellIdentifier: "standardCell")) {
        //        row, element, cell in
        //        cell.textLabel?.text = element
        //    }
        //   .disposed(by: bag)
        
        //cell에 내용 표시 - cellForRowAt: DataSource
        productObservable.bind(to: listTableView.rx.items(cellIdentifier: "productCell", cellType: ProductTableViewCell.self)) {
            [weak self] row, element, cell in
            cell.categoryLabel.text = element.category
            cell.priceLabel.text = self?.priceFormatter.string(for: element.price)
            cell.productNameLabel.text = element.name
            cell.summaryLabel.text = element.summary
        }
        .disposed(by: bag)
        
        //cell 클릭시 eventcjfl - didSelect: Delegate
        
        //#1. 클릭한 cell의 값가져오기: rx.modelSelected 사용
        listTableView.rx.modelSelected(Product.self)
            .subscribe(onNext: { content in
                print(content)
            })
            .disposed(by: bag)
        
        //#2. 클릭한 cell의 indexPath가져오기: rx.itemSelected
        listTableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                //특정 indexPath에 해당하는 cell 클릭 해제하기
                self.listTableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: bag)
        
        //#3. index값이 같은 무언가(여기서는 cell data와 index)를 한 번에 묶어서 코드구현할 때 zip연산자를 활용
        Observable.zip(listTableView.rx.modelSelected(Product.self),listTableView.rx.itemSelected)
            .bind { [weak self] content, indexPath in
                print(content)
                self?.listTableView.deselectRow(at: indexPath, animated: true)
        }
        .disposed(by: bag)
        
        //기존 방식대로 delegate를 연결하면 rx는 작동되지 않음
//        self.listTableView.delegate = self
        
        //rx를 통해 delegate를 연결해야 기존 cocoaTouch(기존 swift)도 겸용하여 사용 가능함.
        listTableView.rx.setDelegate(self).disposed(by: bag)
    }
}

extension RxCocoaTableViewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(#function)
    }
}


