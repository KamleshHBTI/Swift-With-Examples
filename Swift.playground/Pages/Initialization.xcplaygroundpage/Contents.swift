//: [Previous](@previous)

import Foundation
//MARK: Initialization
//Initialization is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that’s required before the new instance is ready for use.

// Unlike Objective-C initializers, Swift initializers don’t return a value.

//Their primary role is to ensure that new instances of a type are correctly initialized before they’re used for the first time.

//Instances of class types can also implement a deinitializer, which performs any custom cleanup just before an instance of that class is deallocated.
class Initialization{
  
  init() {
    // perform some initialization here
  }
}



//MARK: Setting Initial Values for Stored Properties
//Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties can’t be left in an indeterminate state.

//When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any property observers.


//struct Fahrenheit {
//  var temperature:Double
//  init() {
//    temperature = 32.0
//  }
//}

//var f = Fahrenheit()
//print("The default temperature is \(f.temperature)° Fahrenheit")





//MARK: Default Property Values
//If a property always takes the same initial value, provide a default value rather than setting a value within an initializer. The end result is the same, but the default value ties the property’s initialization more closely to its declaration. It makes for shorter, clearer initializers and enables you to infer the type of the property from its default value. The default value also makes it easier for you to take advantage of default initializers and initializer inheritance, as described later in this chapter.

struct Fahrenheit {
  var temperature:Double = 32.0
}

//var f = Fahrenheit()
//print("The default temperature is \(f.temperature)° Fahrenheit")





//MARK: Customizing Initialization
//You can provide initialization parameters as part of an initializer’s definition, to define the types and names of values that customize the initialization process. Initialization parameters have the same capabilities and syntax as function and method parameters.
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
//let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
//print("boiling Point Of Water is",boilingPointOfWater.temperatureInCelsius)
//let freezingPointOfWater = Celsius(fromKelvin: 273.15)
//print("freezing Point Of Water is",freezingPointOfWater.temperatureInCelsius)





//MARK: Parameter Names and Argument Labels
//As with function and method parameters, initialization parameters can have both a parameter name for use within the initializer’s body and an argument label for use when calling the initializer.

struct Color {
    let red, green, blue: Double
    init( red: Double,green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)






//MARK: Optional Property Types
//Properties of optional type are automatically initialized with a value of nil, indicating that the property is deliberately intended to have “no value yet” during initialization.

class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

//let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
//cheeseQuestion.ask()
//cheeseQuestion.response = "Yes, I do like cheese."

//A subclass has to required call parent class init method with super.init()
//A subclass need to initialize all stored type property before super.init() called
class MathQuestion:SurveyQuestion {
  var mathQuestion:String
   init(question: String) {
    self.mathQuestion = question
    super.init(text: "")
  }
}

//let mathQuestion = MathQuestion(question: "Do you like math?")
//print(mathQuestion.ask())





//MARK: Default Initializers
//Swift provides a default initializer for any structure or class that provides default values for all of its properties and doesn’t provide at least one initializer itself. The default initializer simply creates a new instance with all of its properties set to their default values.

class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()





//MARK: Memberwise Initializers for Structure Types
//Structure types automatically receive a memberwise initializer if they don’t define any of their own custom initializers. Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that don’t have default values.

struct Size {
  var width:Double = 0.0
  var height:Double = 0.0
}

//let twoByTwo = Size(width: 2,height: 2)
//print(twoByTwo.height * twoByTwo.width)





//MARK: Initializer Delegation for Value Types
//Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation, avoids duplicating code across multiple initializers.

//Value types (structures and enumerations) don’t support inheritance, and so their initializer delegation process is relatively simple, because they can only delegate to another initializer that they provide themselves.


struct Point {
    var x = 0.0, y = 0.0
}


struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
          //Initializer delegation
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}


//MARK:Class Inheritance and Initialization
//Swift defines two kinds of initializers for class types to help ensure all stored properties receive an initial value. These are known as designated initializers and convenience initializers.

//Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.

//Every class must have at least one designated initializer. In some cases, this requirement is satisfied by inheriting one or more designated initializers from a superclass

//Convenience initializers are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values.

class Desi{
  var name:String
  var age:Int

  init(name:String, age: Int) {
    self.name = name
    self.age = age
  }
  
  convenience init() {
    self.init(name:"Kamlesh", age: 30)
  }
  
  convenience init(firstName:String, lastName:String, age:Int) {
    self.init(name:firstName + lastName, age: age)
  }
}

//var obj = Desi()
//print(obj.name, obj.age)
//var obj1 = Desi(name: "Deepak", age: 31)
//print(obj1.name, obj1.age)
//var obj2 = Desi(firstName: "Simran", lastName: "Singh", age: 29)
//print(obj2.name,obj2.age)




//MARK: Initializer Delegation for Class Types
//To simplify the relationships between designated and convenience initializers, Swift applies the following three rules for delegation calls between initializers:

//MARK:Rule 1
//A designated initializer must call a designated initializer from its immediate superclass.
//MARK:Rule 2
//A convenience initializer must call another initializer from the same class.
//MARK:Rule 3
//A convenience initializer must ultimately call a designated initializer.





//MARK: Two-Phase Initialization
//Class initialization in Swift is a two-phase process. In the first phase, each stored property is assigned an initial value by the class that introduced it. Once the initial state for every stored property has been determined, the second phase begins, and each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use.


//MARK:Safety check 1
//A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.

//class School{
//  var address:String
//  init(address:String) {
//    self.address = address
//  }
//}
//
//class Student: School{
//  var name:String
//  var age:Int
//  init(name:String, age: Int) {
//    self.name = name
//    self.age = age
//    super.init(address: "b-251")
//  }
//}





//MARK:Safety check 2
//A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization.


//class School{
//  var address:String
//  var isEnglishMedium = true
//  init(address:String) {
//    self.address = address
//  }
//}
//
//class Student: School{
//  var name:String
//  var age:Int
//  var typeOfSchool:Bool = false
//  override var isEnglishMedium: Bool{
//    set{
//      self.typeOfSchool = newValue
//    }
//    get{
//      return typeOfSchool
//    }
//  }
//
//  init(name:String, age: Int) {
//    self.name = name
//    self.age = age
//    super.init(address: "b-251")
//    isEnglishMedium = false
//  }
//}




//MARK:Safety check 3
//A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class). If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer.


class School{
  var address:String
  var isEnglishMedium = true
  init(address:String) {
    self.address = address
  }
}

class Student: School{
  var name:String
  var age:Int
  var typeOfSchool:Bool = false
  override var isEnglishMedium: Bool{
    set{
      self.typeOfSchool = newValue
    }
    get{
      return typeOfSchool
    }
  }
  
  init(name:String, age: Int) {
    self.name = name
    self.age = age
    super.init(address: "b-251")
  }
  
  convenience init(typeOfSchool:Bool) {
    //error self.typeOfSchool = typeOfSchool
    self.init(name:"Kamlesh", age: 30)
    //correct self.typeOfSchool = typeOfSchool
  }
}




//MARK:Safety check 4
//An initializer can’t call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.
class Animal{
  var legs:Int
  init(legs: Int) {
    //Incorrect self.AnimalDescription()
    self.legs = legs
  }
  
  func AnimalDescription(){
    print("This animal hase \(legs)")
  }
}




//MARK:Phase 1

//A designated or convenience initializer is called on a class.

//Memory for a new instance of that class is allocated. The memory isn’t yet initialized.

//A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.

//The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.

//This continues up the class inheritance chain until the top of the chain is reached.

//Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.




//MARK:Phase 2
//Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.

//Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.





//MARK: Initializer Inheritance and Overriding
//Unlike subclasses in Objective-C, Swift subclasses don’t inherit their superclass initializers by default. Swift’s approach prevents a situation in which a simple initializer from a superclass is inherited by a more specialized subclass and is used to create a new instance of the subclass that isn’t fully or correctly initialized.

//If you want a custom subclass to present one or more of the same initializers as its superclass, you can provide a custom implementation of those initializers within the subclass.
//class Dog:Animal{
//  var  name:String
//  override init(legs: Int) {
//    super.init(legs: legs)
//  }
//
//   init(ddogName: String) {
//    super.init(legs: 4)
//    self.name = ddogName
//  }
//}

//var dog = Dog(legs: 4)


class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

class Bicycle: Vehicle {
    override init() {
        super.init()
      numberOfWheels = 4
    }
}


//If a subclass initializer performs no customization in phase 2 of the initialization process, and the superclass has a zero-argument designated initializer, you can omit a call to super.init() after assigning values to all of the subclass’s stored properties.

//Subclasses can modify inherited variable properties during initialization, but can’t modify inherited constant properties.


class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}






//MARK: Automatic Initializer Inheritance
//Subclasses don’t inherit their superclass initializers by default. However, superclass initializers are automatically inherited if certain conditions are met. In practice, this means that you don’t need to write initializer overrides in many common scenarios, and can inherit your superclass initializers with minimal effort whenever it’s safe to do so.

//Assuming that you provide default values for any new properties you introduce in a subclass, the following two rules apply:

//MARK: Rule 1
//If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers.


//MARK: Rule 2
//If your subclass provides an implementation of all of its superclass designated initializers—either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition—then it automatically inherits all of the superclass convenience initializers.


class Food {
    var name: String
    init(name: String) {
        print("CCC")
        self.name = name
    }
    convenience init() {
      print("DDD")
        self.init(name: "[Unnamed]")
    }
}

//let namedMeat = Food(name: "Bacon")
// namedMeat's name is "Bacon"

//let mysteryMeat = Food()
// mysteryMeat's name is "[Unnamed]"


class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        print("AAA")
        super.init(name: name)
        
    }
    override convenience init(name: String) {
        print("BBB")
        self.init(name: name, quantity: 1)
    }
  
}

//let oneMysteryItem = RecipeIngredient()
//let oneBacon = RecipeIngredient(name: "Bacon")
//let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)






//MARK: Failable Initializers
//It’s sometimes useful to define a class, structure, or enumeration for which initialization can fail. This failure might be triggered by invalid initialization parameter values, the absence of a required external resource, or some other condition that prevents initialization from succeeding.

//You write a failable initializer by placing a question mark after the init keyword (init?).

//You can’t define a failable and a nonfailable initializer with the same parameter types and names.

//A failable initializer creates an optional value of the type it initializes. You write return nil within a failable initializer to indicate a point at which initialization failure can be triggered.

//






//MARK:Failable Initializers for Enumerations
//You can use a failable initializer to select an appropriate enumeration case based on one or more parameters. The initializer can then fail if the provided parameters don’t match an appropriate enumeration case.

//The example below defines an enumeration called TemperatureUnit, with three possible states (kelvin, celsius, and fahrenheit). A failable initializer is used to find an appropriate enumeration case for a Character value representing a temperature symbol:

//enum TemperatureUnit {
//    case kelvin, celsius, fahrenheit
//  init?(symbol: Character) {
//        switch symbol {
//        case "K":
//            self = .kelvin
//        case "C":
//            self = .celsius
//        case "F":
//            self = .fahrenheit
//        default:
//            return nil
//        }
//    }
//
//}

//let fahrenheitUnit = TemperatureUnit(symbol: "F")
//print(fahrenheitUnit)





//MARK:Failable Initializers for Enumerations with Raw Values
//Enumerations with raw values automatically receive a failable initializer, init?(rawValue:), that takes a parameter called rawValue of the appropriate raw-value type and selects a matching enumeration case if one is found, or triggers an initialization failure if no matching value exists.

enum TemperatureUnit: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}

let fahrenheitUnit = TemperatureUnit(rawValue: "K")
if fahrenheitUnit != nil {
//    print("This is a defined temperature unit, so initialization succeeded.")
}





//MARK:Propagation of Initialization Failure
//A failable initializer of a class, structure, or enumeration can delegate across to another failable initializer from the same class, structure, or enumeration. Similarly, a subclass failable initializer can delegate up to a superclass failable initializer.

//A failable initializer can also delegate to a nonfailable initializer. Use this approach if you need to add a potential failure state to an existing initialization process that doesn’t otherwise fail.



class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}





//MARK: Overriding a Failable Initializer
//You can override a superclass failable initializer in a subclass, just like any other initializer. Alternatively, you can override a superclass failable initializer with a subclass nonfailable initializer. This enables you to define a subclass for which initialization can’t fail, even though initialization of the superclass is allowed to fail.

//Note that if you override a failable superclass initializer with a nonfailable subclass initializer, the only way to delegate up to the superclass initializer is to force-unwrap the result of the failable superclass initializer.


class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init() {
      print("BBB")
    }
    // this initializer creates a document with a nonempty name value
    init?(name: String) {
      print("CCC")
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        print("AAA")
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
      print("DDD")
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

//let automaticallyNamedDocument = AutomaticallyNamedDocument(name: "JAVA")
//print(automaticallyNamedDocument.name)





//MARK: Required Initializers
//Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer:

class SomeClass {
  var name:String
  var age:Int
  
  required init(_ name:String,_ age:Int) {
    self.name = name
    self.age = age
    }
}


class SomeChildClass: SomeClass{
  var address:String
  init(address:String) {
    self.address = address
    super.init("Deepak", 30)
  }
  
  required init(_ name: String, _ age: Int) {
    self.address = "USA"
    super.init(name, age)
  }
}

let someChildClass = SomeChildClass(address: "B-251 sector 19 noida")
print(someChildClass.address, someChildClass.age, someChildClass.name)
let reqObj = SomeChildClass("Jeck", 40)
print(reqObj.address, reqObj.age, reqObj.name)

//: [Next](@next)
