//: [Previous](@previous)

import Foundation
import Darwin
import UIKit


//MARK: Synchronous and asynchronous tasks

//Synchronous
let queue = DispatchQueue(label: "com.raywenderlich.worker", attributes: .concurrent)
queue.sync {
  sleep(3)
  print("queue sync task 1")
}
queue.activate()

queue.sync {
  print("queue sync task 2")
}

//Asynchronous
queue.async {
  sleep(3)
  print("queue async task 1")
}
queue.activate()

queue.async {
  print("queue async task 2")
}

//MARK: Asynchronous doesn't mean concurrent
//Unlike GCD, an operation is run synchronously by default. While you can directly execute an operation yourself, that's almost never going to be a good idea due to its synchronous nature.
//MARK: BlockOperation
//A BlockOperation manages the concurrent execution of one or more closures on the default global queue
//BlockOperation manages a group of closures. It acts similar to a dispatch group in that it marks itself as being finished when all of the closures have finished
//Tasks in a BlockOperation run concurrently. If you need them to run serially, submit them to a private DispatchQueue or set up dependencies.
//When you want to add additional closures to the BlockOperation, you'll call the addExecutionBlock method and simply pass in a new closure.


let blockOperation = BlockOperation {
  print("BlockOperation")
}
//blockOperation.start()

let sentence = "Ray's courses are the best!"
let wordOperation = BlockOperation()

for word in sentence.split(separator: " ") {
  wordOperation.addExecutionBlock {
    print(word)
  }
}

wordOperation.completionBlock = {
  print("We have completed all task")
}

//wordOperation.start()






//MARK: OperationQueue
//OperationQueue handle your operations. Just like with GCD's DispatchQueue, the OperationQueue class is what you use to manage the scheduling of an Operation and the maximum number of operations that can run simultaneously

//OperationQueue allows you to add work in three separate ways:
//• Pass an Operation.
//• Pass a closure.
//• Pass an array of Operations.


var operationQueue = OperationQueue()
//sync type


//operationQueue.addOperation {
//  print("addOperation 1")
//  sleep(2)
//}
//operationQueue.addOperation {
//  print("addOperation 2")
//}
//operationQueue.addOperation {
//  print("addOperation 3")
//  sleep(2)
//}


//async type

let operation1 = Operation()
operation1.completionBlock = {
  print("addOperations 1")
  sleep(2)
}

let operation2 = Operation()
operation2.completionBlock = {
  print("addOperations 2")
}
let operation3 = Operation()
operation3.completionBlock = {
  print("addOperations 3")
}

//operationQueue.maxConcurrentOperationCount = 2
//operationQueue.addOperations([operation1, operation2, operation3], waitUntilFinished: false)
//operationQueue.isSuspended = true
//operationQueue.waitUntilAllOperationsAreFinished()






//Operations dependencies


let depoperation1 = Operation()
depoperation1.completionBlock = {
  print("depoperation1 1")
}

let depoperation2 = Operation()
depoperation2.completionBlock = {
  print("depoperation2 2")
}
let depoperation3 = Operation()
depoperation3.completionBlock = {
  print("depoperation3 3")
  sleep(2)
}

depoperation1.addDependency(operation2)
operation3.addDependency(operation2)
operationQueue.maxConcurrentOperationCount = 1
operationQueue.addOperations([depoperation1, depoperation2, depoperation3], waitUntilFinished: true)



//: [Next](@next)
