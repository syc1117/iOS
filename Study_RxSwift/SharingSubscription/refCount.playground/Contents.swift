
import UIKit
import RxSwift

/*:
 # refCount: 구독자가 있으면 알아서 .connect실행했다가 구독자가 isDisposed되면 자동으로 disConnect됨.
 
 **refCount()가 있을 때와 없을 때의 차이: 없을 때는 하나의 시퀀스가 별도의 정지 명령이 있기 전까지 계속 실행되고 있기 때문에, 나중에 구독을 시작한 구독자는 시퀀스 중간 값부터 구독을 시작하지만, 레포카운터가 있을 경우에는 앞서 먼저 구독을 시작한 구독자가 구독을 마쳤을 때 isConnect되었다가 다음 구독자가 구독을 시작할 때 다시 connect되면서 처음 값부터 값을 가져오기 시작함.
 **구독자1이 아직 구독을 마치기 전에 구독자 2가 중간에 구독을 시작하면 중간 값부터 방출된 것을 구독하기 시작함. 자동문을 생각하면 됨.
 */


let bag = DisposeBag()
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).debug().publish().refCount()

let observer1 = source
   .subscribe { print("🔵", $0) }

//source.connect()

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
   observer1.dispose()
}

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
   let observer2 = source.subscribe { print("🔴", $0) }

   DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      observer2.dispose()
   }
}








