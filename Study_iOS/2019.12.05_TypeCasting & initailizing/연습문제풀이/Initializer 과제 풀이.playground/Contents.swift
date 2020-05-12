
/*
 - Vehicle 클래스에 지정 이니셜라이져(Designated Initializer) 추가
 - Car 클래스에 modelYear 또는 numberOfSeat가 0 이하일 때 nil을 반환하는 Failable Initializer 추가
 - Bus 클래스에 지정 이니셜라이져를 추가하고, maxSpeed를 100으로 기본 할당해주는 편의 이니셜라이져 추가
 */

class Vehicle {
  let name: String
  let maxSpeed: Int
  
  init(name: String, maxSpeed: Int) {
    self.name = name
    self.maxSpeed = maxSpeed
  }
}

class Car: Vehicle {
  var modelYear: Int
  var numberOfSeats: Int
  
  init?(name: String, maxSpeed: Int, modelYear: Int, numberOfSeats: Int) {
    guard modelYear > 0, numberOfSeats > 0 else { return nil }
    self.modelYear = modelYear
    self.numberOfSeats = numberOfSeats
    super.init(name: name, maxSpeed: maxSpeed)
  }
}


class Bus: Vehicle {
  let isDoubleDecker: Bool
  init(name: String, maxSpeed: Int, isDoubleDecker: Bool) {
    self.isDoubleDecker = isDoubleDecker
    super.init(name: name, maxSpeed: maxSpeed)
  }
  
  convenience init(name: String, isDoubleDecker: Bool) {
    self.init(name: name, maxSpeed: 100, isDoubleDecker: isDoubleDecker)
  }
}


let vehicle = Vehicle(name: "Vehicle", maxSpeed: 100)
let car = Car(name: "Car", maxSpeed: 150, modelYear: 2010, numberOfSeats: 4)
let fail = Car(name: "Car", maxSpeed: 150, modelYear: 0, numberOfSeats: 0)
let bus = Bus(name: "Bus", isDoubleDecker: true)
