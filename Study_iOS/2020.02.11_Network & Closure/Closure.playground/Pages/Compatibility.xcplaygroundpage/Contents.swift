//: [Previous](@previous)
import Foundation
/*:
 # Compatibility
 */
/*
 (O) @noescaping -> @noescaping
 (O) @escaping   -> @noescaping, @escaping
 (X) @noescaping -> @escaping
 */

class Test {
  var storedProperty: (() -> ())?
  
  func someFunction(_ param: ()->()) {
    noEscapingClosure(param)    // (O) NoEscaping -> NoEscaping

//    self.storedProperty = param    // (X) required @escaping
//    escapingClosure(param)   // (X) NoEscaping -> Escaping
  }
  
  func noEscapingClosure(_ param: () -> ()) {
    param()
//    self.storedProperty = param   // (X)
  }
  
  func escapingClosure(_ param: @escaping () -> ()) {
    self.storedProperty = param
  }
}



//: [Next](@next)
