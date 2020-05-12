//: [Previous](@previous)
//: - - -
//: # Getters and Setters
//: - - -
/***************************************************
 Getter 와 Setter 는 그것이 속하는 변수, 상수 등에 대해 동일한 접근 레벨을 가짐
 이 때 Getter 와 Setter 에 대해서 각각 다른 접근 제한자 설정 가능
 ***************************************************/

/***************************************************
 Setter 설정
 ***************************************************/

class TrackedString {
//  var numberOfEdits = 0

//  private var numberOfEdits = 0 //이 경우에는 읽는 것 조차 외부에서 할 수 없으기때문에 오류가 발생함.
  private(set) var numberOfEdits = 0 //외부에서 값을 입력 할 수는 없지만 클래스 내부의 작동코드에 의해서 변동되는 것은 허용함. setter(값변경)에 대해서만 (외부로부터) 차단을 적용하고 읽는 것은 외부에서도 됨.

  var value: String = "" {
    didSet {
      numberOfEdits += 1
    }
  }
}


let trackedString = TrackedString()
trackedString.numberOfEdits
trackedString.value = "This string will be tracked."
trackedString.numberOfEdits

trackedString.value += " This edit will increment numberOfEdits."
trackedString.numberOfEdits

trackedString.value = "value changed"
trackedString.numberOfEdits

//trackedString.numberOfEdits = 0
//trackedString.numberOfEdits


/***************************************************
 Getter 와 Setter 에 대해 각각 명시적으로 표현
 ***************************************************/

public class TrackedString1 {
  internal private(set) var numberOfEdits = 0
  
  public var value: String = "" {
    didSet {
      numberOfEdits += 1
    }
  }
  
  public init() {}
}

//: [Next](@next)
