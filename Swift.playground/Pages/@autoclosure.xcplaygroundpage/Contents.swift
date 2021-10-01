//: [Previous](@previous)

import Foundation
import UIKit
import Darwin

//MARK: Autoclosure
//MARK: Swift’s @autoclosure attribute enables you to define an argument that automatically gets wrapped in a closure. It’s primarily used to defer execution of a (potentially expensive) expression to when it’s actually needed, rather than doing it directly when the argument is passed.

//MARK: One example of when this is used in the Swift standard library is the assert function. Since asserts are only triggered in debug builds, there’s no need to evaluate the expression that is being asserted in a release build. This is where @autoclosure comes in:

func assert(_ expression: @autoclosure  () -> Bool,
            _ message: @autoclosure () -> String) {
    guard isDebug() else {
        return
    }

    // Inside assert we can refer to expression as a normal closure
    if !expression() {
        assertionFailure(message())
    }
}


//MARK: The nice thing about @autoclosure is that it has no effect on the call site. If assert was implemented using “normal” closures you’d have to use it like this:


assert(someCondition(), "Hey it failed!")

func someCondition()->Bool{return true}

func isDebug() -> Bool{return false}




//MARK: Inlining assignments
//MARK: One thing that @autoclosure enables is to inline expressions in a function call. This enables us to do things like passing assignment expressions as an argument. Let’s take a look at an example where this can be useful.

//On iOS, you normally define view animations using this API:

//UIView.animate(withDuration: 0.25) {
//    view.frame.origin.y = 100
//}


func animate(_ animation: @autoclosure @escaping () -> Void,
             duration: TimeInterval = 0.25) {
  UIView.animate(withDuration: duration, animations: animation)
}

animate(UIView().frame.origin.y = 100)



//MARK: Passing errors as expressions
//MARK: Another situation that I find @autoclosure very useful in is when writing utilities that deal with errors. For example, let’s say we want to add an extension on Optional that enables us to unwrap it using a throwing API. That way we can require the optional to be non-nil, or else throw an error, like this:

extension Optional {
    func unwrapOrThrow(_ errorExpression: @autoclosure () -> Error) throws -> Wrapped {
        guard let value = self else {
            throw errorExpression()
        }

        return value
    }
}

enum ArgumentError: Error{
  case missingName
}

let name = try argument(at: 1).unwrapOrThrow(ArgumentError.missingName)
print(name)

func argument(at: Int) -> String?{
  return nil
}

//: [Next](@next)
