//: [Previous](@previous)

import Foundation
//MARK: Genric
//Genric is way of write flexible and resuable peice of code. A code that can take anytype.

//e.g
func swapTwoValues<T>(_ valueA:inout T, _ valueB: inout T){
  let temp = valueA
  valueA = valueB
  valueB = temp
}


//MARK: What is an associated type?
//An associated type can be seen as a replacement of a specific type within a protocol definition. In other words: it’s a placeholder name of a type to use until the protocol is adopted and the exact type is specified.

//e.g
protocol Stack{
  associatedtype item
  var stackArr: [item] {get set}
  mutating func push(_ item: item)
  func pop()
}


//MARK: What are the benefits of using associated types?
//The benefits of an associated type should become visible once you start working with them. They prevent writing duplicate code by making it easier to define a common interface for multiple scenarios. This way, the same logic can be reused for multiple different types, allowing you to write and test logic only once.



//MARK: The Problem That Opaque Types Solve
//For example, suppose you’re writing a module that draws ASCII art shapes. The basic characteristic of an ASCII art shape is a draw() function that returns the string representation of that shape, which you can use as the requirement for the Shape protocol:



protocol Shape {
  func draw() -> String
}

struct Triangle: Shape {
  var size: Int
  func draw() -> String {
    var result: [String] = []
    for length in 1...size {
      result.append(String(repeating: "*", count: length))
    }
    return result.joined(separator: "\n")
  }
}
let smallTriangle = Triangle(size: 3)
//print(smallTriangle.draw())

//You could use generics to implement operations like flipping a shape vertically, as shown in the code below. However, there’s an important limitation to this approach: The flipped result exposes the exact generic types that were used to create it.



struct FlippedShape<T:Shape>: Shape{
  var shape: T
  
  func draw() -> String {
    let lines = shape.draw().split(separator: "\n")
    return lines.reversed().joined(separator: "\n")
  }
  
}

let flippedTriangle = FlippedShape(shape: smallTriangle)
//print(flippedTriangle.draw())



//This approach to defining a JoinedShape<T: Shape, U: Shape> structure that joins two shapes together vertically, like the code below shows, results in types like JoinedShape<FlippedShape<Triangle>, Triangle> from joining a flipped triangle with another triangle.


struct JoinedShape<T: Shape, U: Shape>: Shape {
  var top: T
  var bottom: U
  func draw() -> String {
    return top.draw() + "\n" + bottom.draw()
  }
}
let joinedTriangles = JoinedShape(top: smallTriangle, bottom: flippedTriangle)
//print(joinedTriangles.draw())




//MARK: Opaque Type
//You can think of an opaque type like being the reverse of a generic type. Generic types let the code that calls a function pick the type for that function’s parameters and return value in a way that’s abstracted away from the function implementation. For example, the function in the following code returns a type that depends on its caller:


struct Square: Shape {
  var size: Int
  func draw() -> String {
    let line = String(repeating: "*", count: size)
    let result = Array<String>(repeating: line, count: size)
    return result.joined(separator: "\n")
  }
}

func makeTrapezoid() -> some Shape {
  let top = Triangle(size: 2)
  let middle = Square(size: 2)
  let bottom = FlippedShape(shape: top)
  let trapezoid = JoinedShape(
    top: top,
    bottom: JoinedShape(top: middle, bottom: bottom)
  )
  return trapezoid
}
let trapezoid = makeTrapezoid()
print(trapezoid.draw())


//MARK: Opaque type example

enum CaredType{
  case gold
  case platinum
}

protocol CardNumberProtocol{
  
}

extension String: CardNumberProtocol{
  
}

protocol Card{
  associatedtype cardNumber: CardNumberProtocol
  var cardType: CaredType {get set}
  var limit: Int{get set}
  var number: cardNumber{get set}
  func validatedCardNumber(number: cardNumber)
}


struct VisaCard: Card{
  typealias cardNumber = String
  var cardType: CaredType = .gold
  var limit: Int = 50000
  var number: String = "4141 4542 4542"
  func validatedCardNumber(number: String) {
    
  }
}

struct MasterCard: Card{
  typealias cardNumber = String
  var cardType: CaredType = .platinum
  var limit: Int = 60000
  var number: String = "4141 5455 2525 8776"
  
  func validatedCardNumber(number: String) {
    
  }
}

func getLoanElegibility() -> Bool{
  getUserCard().limit >= getLoanElegibilityCard().limit
}

func getUserCard() -> some Card{
  MasterCard()
}

func getLoanElegibilityCard() -> some Card{
  VisaCard()
}
//: [Next](@next)
