//: [Previous](@previous)

import Foundation
import UIKit
import FileProvider
import CloudKit

//MARK: Typealias
//A typealias in Swift is literally an alias for an existing type. Simple, isn’t it? They can be useful in making your code a bit more readable. By using them in a smart way they can be really useful in your codebase.



//MARK: Declaring a typealias
//A typealias can be declared in Swift using the typealias keyword followed by the type you want to assign. A very simple example to understand how they can be used is by making an alias for currency, like Dollars. Take the following example of a receipt struct:

typealias Doller = Double
typealias Euro = Double

struct Receipt{
  let totalCosts: Doller
}

extension Receipt{
  func toEuro() -> Euro{
    return totalCosts * 0.896
  }
}

let receipt = Receipt(totalCosts: 10)
print(receipt.toEuro())



//A typealias can be useful to improve readability throughout your codebase as you can see. See what it can do for your project and try to make your code self documenting.

//: [Next](@next)
