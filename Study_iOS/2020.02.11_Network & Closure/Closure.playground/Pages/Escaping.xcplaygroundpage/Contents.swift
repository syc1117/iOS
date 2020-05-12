//: [Previous](@previous)
import Foundation
/*:
 ---
 # Escaping
 - 함수나 메서드의 파라미터 중 클로져 타입에 @escaping 키워드 적용
 - 해당 파라미터가 함수 종료(return) 이후 시점에도 어딘가에 남아 실행될 수 있음을 나타냄
   - outlives the lifetime of the function
 - 해당 파라미터가 함수 외부에 저장(stored)되거나 async(비동기)로 동작할 때 사용
 - self 키워드 명시 필요
 ---
 */

//@escaping의 경우 함수가 종료되고 난 이후에 실행이 되어야 하기 때문에 함수가 종료되어도 살아 있어야함. 이 경우에는 self.를 붙여주어야 함. self찍으라고 compiler오류가 나는 것들은 전부 @escaping함수들이라고 보면 됨.
//정확히 self를 써야 하는 경우는, 함수 종료 이후 파라미터로 지정되어 있는 함수가 실행되어야 하는 경우 사용하는 것. 그 중 하나가 @escaping함수인 것.
//"함수 외부에 있는 변수를 쓰는" 함수가 함수 종료 후에도 해당 변수를 가지고 무언가를 해야 할 때, 그 변수를 계속 지니고 있어야 하는데, 이때 self.가 해당 변수를 계속 지니고 있도록 해주는 것임. 따라서, self.를 찍게 되면 self.변수를 가지고 있는 class의 참조카운트가 올라가게 됨. 모든 함수가 다 종료되면 self.부터 차례로 참조카운트가 벗겨짐.

class Callee {
  deinit { print("Callee has deinitialized") }
  
  func noEscapingFunc(closure: () -> Void) {
    print("1")
    closure()
  }
    
  func escapingFunc(closure: @escaping () -> Void) {
    print("1")
    closure()
    
    }
}

let a = Caller()
class Caller {
  deinit { print("Caller has deinitialized") }
  let callee = Callee()
  var name = "James"
  
  func selfKeyword() {
    // self keyword (X)
    callee.noEscapingFunc { name = "Giftbot" }
    
    // self keyword  (O)
    callee.escapingFunc { self.name = "Giftbot" }
  }
  
  
  
  func asyncTask() {
    callee.noEscapingFunc {
      DispatchQueue.main.async {
        self.name = "Giftbot"  //async 자체가 @escaping 함수 func async(group: DispatchGroup? = nil, qos: DispatchQoS = .unspecified, flags: DispatchWorkItemFlags = [], execute work: @escaping @convention(block) () -> Void)
      }
    }
    callee.escapingFunc {
      DispatchQueue.main.async {
        self.name = "Giftbot"
      }
    }
  }
  
  
  func captureAsStrong() {
    callee.escapingFunc {
      print("-- delay 2seconds --")
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        self.name = "Giftbot"
      }
    }
  }
  
  func weakBinding() {
    callee.escapingFunc { [weak self] in// self가 가리키는(name을 가지고있는 class)가 nil이 되는 순간(deinit되는 순간)에 self자체가 nil이 되면서 self.name은 실행되지 않음. 즉, self가 가리키는 객체가 nil이 되는 순간 self가 붙어있는 코드들은 실행되지 않고 모두 죽어버림.
        //여기서는 caller = nil하는 순간 let callee = Callee()도 연달아 nil이 되고, DispatchQueue는 비록 살아있어서 .now() + 2에 실행이 되지만, 그 안에 있는 self?.name = "Giftbot"; print(self?.name ?? "nil")는 이미 참조 해제되어 실행되지 않음.
        //[weak self]쓰고 안쓸 때의 차이: deinit이 호출되는 시점이 다름. 쓰면 self가 해제되는 시점에 self가 붙은 모든 것이 nil을 반환하게 되고, 안쓰면 self가 붙은 모든 것이 종료되고 나서 deinit이 됨.
        //****중요: 어느경우에 [weak self]을 쓰고 쓰지 말아야 할까? -> self가 해제되는 것과 관계없이 끝까지 남아서 어떻게든 코드를 실행시켜야 하는 경우에는 쓰면안되고, 즉시 같이 해제되기를 원하면 써야함.
        //
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        print("-- after 2seconds with weak self --")
        self?.name = "Giftbot"
        print(self?.name ?? "nil")
      }
    }

    
//    callee.escapingFunc { [weak self] in
//      guard let `self` = self else { return print("Caller no exist") }
//      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//        print("-- after 2seconds with weak self --")
//        self.name = "Giftbot"
//      }
//    }
  }
  
  func unownedBinding() {
    callee.escapingFunc { [unowned self] in
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        print("-- after 2seconds with unowned self --")
        print("Oops!!")
        
        self.name = "Giftbot"
        print(self.name)
      }
    }
  }
}


var caller: Caller? = Caller()
caller?.selfKeyword()
//caller?.asyncTask()
//caller?.captureAsStrong()
//caller?.weakBinding()
//caller?.unownedBinding()

print("caller = nil")
caller = nil




//: [Next](@next)
