//: [Previous](@previous)

import Foundation

//MARK: ThreadSanitizer
//Thread Sanitizer prevents data races conditions. Data Races occur when the same memory accessed from multiple thread without synchronization and at least one access is write it. Data races can lead to serveral issues

//Unpredictable behavior
//Memory corruption
//Flaky tests
//Weird crashes

private var name:String = ""

func updateName(){
  let globalQueue = DispatchQueue.global()
  globalQueue.async {
    for char in "Kamlesh kumar"{
          name.append(char)
    }
  }
  print(name)
}

updateName()




//MARK: A Data Race caused by a lazy variable
class ThreadSanitizer{
  private lazy var lazyName:String = "Hello ThreadSanitizer "
  
  func updateName(){
    DispatchQueue.global().async {
      print(self.lazyName)
    }
    print(self.lazyName)
  }

}

let instance = ThreadSanitizer()
instance.updateName()
//: [Next](@next)
