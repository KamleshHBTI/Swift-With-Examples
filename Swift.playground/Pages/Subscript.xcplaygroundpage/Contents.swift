//: [Previous](@previous)

import Foundation
import UIKit

//MARK: Classes, structures and enumerations can define subscripts, which are shortcuts for accessing the member elements of a collection, list or sequence.
//MARK: you can define multiple subscripts for a single type.
//MARK: Subscript can't be use inout parametres

class ClassSubscript{
  
  var age:Int?
  var name: String?

  //MARK: Age Subscript
  subscript(initialAge: Int)-> Int{
    get{
      return ((age ?? 0) + initialAge)
    }
    set(newValue){
      age = newValue * initialAge
    }
  }
  
  //MARK: Name Subscript
  subscript(myName: String)-> String{
    get{
      return name ?? ""
    }
    set(newValue){
      print("namee", myName)
      name = newValue + " and age is \(age ?? 0)"
    }
  }
}
//
//var obj = ClassSubscript()
//obj[3] = 15
//print(obj[0])
//obj[""] = "Kamlesh"
//print(obj[1])
//print(obj[""])




//MARK: Usage of subsripts

//var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
//numberOfLegs["bird"] = 2
//print(numberOfLegs)
//numberOfLegs["bird"] = nil
//print(numberOfLegs)



//MARK: subsripts Options

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
          assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
          assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var structObj = Matrix(rows: 2, columns: 2)
//structObj[0,0] = 1
//structObj[0,1] = 2
//structObj[1,0] = 3
//structObj[1,1] = 4
print(structObj[1,1])
print(structObj.grid)

//: [Next](@next)
