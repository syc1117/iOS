
import UIKit
import RxSwift

/*:
 # Sharing Subscription
 */
//share(): 같은 내용을 구독하는 코드에 대해서 앞에서 결과값이 있으면 또 다시 반복실행하지 않고 결과값을 공유하도록 함으로써 리소스를 절약시켜 줌.

let bag = DisposeBag()

let source = Observable<String>.create { observer in
   let url = URL(string: "https://kxcoding-study.azurewebsites.net/api/string")!
   let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      if let data = data, let html = String(data: data, encoding: .utf8) {
         observer.onNext(html)
      }
      
      observer.onCompleted()
   }
   task.resume()
   
   return Disposables.create {
      task.cancel()
   }
}
.debug()
.share() // 지우고 실행해보고 첨부하고 실행해서 결과 비교해 볼 것.

//source.subscribe().disposed(by: bag)
//source.subscribe().disposed(by: bag)
//source.subscribe().disposed(by: bag)

source.subscribe{print($0)}.disposed(by: bag)
source.subscribe{print($0)}.disposed(by: bag)
source.subscribe{print($0)}.disposed(by: bag)
