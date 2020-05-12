//
//  SomeClass.swift
//  AccessControl
//
//  Created by giftbot on 18/11/2019.
//  Copyright © 2018 giftbot. All rights reserved.
//

import Foundation

private class PrivateClass { // 클래스 앞에 private을 붙여도 fileprivate처럼 작동하게 됨. fileprivate은 서로 다른 파일에서는 서로 관여할 수 없음(값 변경 등)그러나 같은 파일 안에서는 접근 가능함. 그냥 private은 클래스가 다르면 접근할 수 없음. 일반적으로 하나의 파일에 하나의 클래스를 사용하므로 거의 private을 사용함. 
  public var publicProperty = 100
  internal var internalProperty = 200
  fileprivate var fileprivateProperty = 300
  private var privateProperty = 400
  
  // default 는 fileprivate 처럼 동작
  var defaultProperty = 500
  
  func someFileprivateFunction() {
  }
  private func somePrivateFunction() {
  }
}


class SomeOtherClass {
  // fileprivate 또는 private 으로 설정 필요
  fileprivate let privateClass = PrivateClass()
//  private let privateClass = PrivateClass()

  func someFunction() {
    let privateClass = PrivateClass()
    print(privateClass.publicProperty)
    print(privateClass.internalProperty)
    print(privateClass.fileprivateProperty)
//    print(privateClass.privateProperty)  // 접근 불가
    
    print(privateClass.defaultProperty)    // = fileprivate
    
    privateClass.someFileprivateFunction()
//    privateClass.somePrivateFunction()   // 접근 불가
  }
}


// Swift 4 부터 Private 레벨의 접근 수준 확장
// 버전 4 이전에는 같은 파일 내에서라도 extension 을 추가하기 위해서 fileprivate 사용
extension PrivateClass {
  var extendVariable: String {
    return ""
  }
}
