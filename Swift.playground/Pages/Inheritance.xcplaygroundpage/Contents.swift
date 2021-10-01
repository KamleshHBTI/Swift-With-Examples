//: [Previous](@previous)

import Foundation

//MARK: Inheritance
//A class can inherit methods, properties, and other characteristics from another class. When one class inherits from another, the inheriting class is known as a subclass, and the class it inherits from is known as its superclass.





//MARK: Defining a Base Class
//Any class that doesn’t inherit from another class is known as a base class.

//Swift classes don’t inherit from a universal base class. Classes you define without specifying a superclass automatically become base classes for you to build upon.

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}

//let someVehicle = Vehicle()
//print("Vehicle: \(someVehicle.description)")





//MARK: Subclassing

//The new Bicycle class automatically gains all of the characteristics of Vehicle, such as its currentSpeed and description properties and its makeNoise() method.

class Bicycle: Vehicle {
    var hasBasket = false
}

//let bicycle = Bicycle()
//bicycle.hasBasket = true
//bicycle.currentSpeed = 15.0
//print("Bicycle: \(bicycle.description)")




//MARK: Subclasses can themselves be subclassed.
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

//let tandem = Tandem()
//tandem.hasBasket = true
//tandem.currentNumberOfPassengers = 2
//tandem.currentSpeed = 22.0
//print("Tandem: \(tandem.description)")




//MARK: Overriding
//A subclass can provide its own custom implementation of an instance method, type method, instance property, type property, or subscript that it would otherwise inherit from a superclass. This is known as overriding.

//Cannot override with a stored property but you can modify stored type property in subclasses

//any overrides without the override keyword are diagnosed as an error when your code is compiled

//overrides can be in multiple in children or sub classes

//An overridden method named someMethod() can call the superclass version of someMethod() by calling super.someMethod() within the overriding method implementation.

//An overridden property called someProperty can access the superclass version of someProperty as super.someProperty within the overriding getter or setter implementation.

//You can present an inherited read-only property as a read-write property by providing both a getter and a setter in your subclass property override. You can’t, however, present an inherited read-write property as a read-only property.


class Bike: Vehicle {

  var gear = 1

  //override var currentSpeed = 60.0
  
  override func makeNoise(){
    super.makeNoise()
  }
  
  private var descriptionStr:String?
  override var description: String{
    //currentSpeed = 60.0
    set(newValue){
      descriptionStr = newValue
    }
    get{
      return super.description + " in gear \(gear)"
    }
  }
}

let myBike = Bike()
//print(myBike.makeNoise())
print(myBike.description)




//MARK: Preventing Overrides
//You can prevent a method, property, or subscript from being overridden by marking it as final. Do this by writing the final modifier before the method, property, or subscript’s introducer keyword (such as final var, final func, final class func, and final subscript).

final class Car{
  
  var fourVichler = 4
}

//class Parts:Car{
//
//}


//MARK: private supar class can't be inheriated until subclass is same access(like private)

//MARK:Class computed type properties and method can be override not static type properties and method

//MARK:
//: [Next](@next)
