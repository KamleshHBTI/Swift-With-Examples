//: [Previous](@previous)

import UIKit
import Foundation


//MARK: Concurrency


//If you’ve written concurrent code before, you might be used to working with threads. The concurrency model in Swift is built on top of threads, but you don’t interact with them directly. An asynchronous function in Swift can give up the thread that it’s running on, which lets another asynchronous function run on that thread while the first function is blocked.

//the following code downloads a list of photo names, downloads the first photo in that list, and shows that photo to the user



// listPhotos(inGallery: "Summer Vacation") { photoNames in
//    let sortedNames = photoNames.sorted()
//    let name = sortedNames[0]
//    downloadPhoto(named: name) { photo in
//        show(photo)
//    }
//}


//Even in this simple case, because the code has to be written as a series of completion handlers, you end up writing nested closures. In this style, more complex code with deep nesting can quickly become unwieldy.


//MARK: What is async?
//Async stands for asynchronous and you write the async keyword in its declaration after its parameters and method attribute making it clear that a method performs asynchronous work. An example of such a method looks as follows:

//func fetchImages() async throws -> [UIImage] {
//    // .. perform data request
//}


//MARK: What is await?
//Await is the keyword to be used for calling async methods. You can see them as best friends in Swift as one will never go without the other. You could basically say: “Await is awaiting a callback from his buddy async”

//await fetchImages()


//MARK: Defining and Calling Asynchronous Functions

//An asynchronous function or asynchronous method is a special kind of function or method that can be suspended while it’s partway through execution.

//

func listPhotos(inGallery name: String) async -> [String] {
  let result =  ["Kamlesh", "Deeapk","Ramesh"] // ... some asynchronous networking code ...
  Thread.sleep(forTimeInterval: 5)
//  print("BB")
  return result
}


//async{
//  let photos = await listPhotos(inGallery: "dummy photos")
////  print("AA")
//  print(photos)
//}


//This is in contrast to ordinary, synchronous functions and methods, which either run to completion, throw an error, or never return. An asynchronous function or method still does one of those three things, but it can also pause in the middle when it’s waiting for something. Inside the body of an asynchronous function or method, you mark each of these places where execution can be suspended.


let url = URL(string: "https://jsonplaceholder.typicode.com/users")

// MARK: - User
struct User: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String
}


func listUsers(inGallery name: String) async  -> [User] {
  do{
    let (data,_) =  try await URLSession.shared.data(from: url!)
    let user = try JSONDecoder().decode([User].self, from: data)
    sleep(1)
//    print("Deepak")
    return user
  }
  catch{
    return []
  }
}

func FetchUsers(){
  Task.init(priority: .background, operation: {
   let users =  await listUsers(inGallery: "User gallery")
    print(users[0])
  })
  
}

//FetchUsers()
//print("Hello DMI")

//When calling an asynchronous method, execution suspends until that method returns. You write await in front of the call to mark the possible suspension point. Inside an asynchronous method, the flow of execution is suspended only when you call another asynchronous method—suspension is never implicit or preemptive—which means every possible suspension point is marked with await.





//For a function or method that’s both asynchronous and throwing, you write async before throws. and where from this method we called put try before await call


func UserBasedOnCountry(country:String) async throws -> [User]{
  do {
    let (data,_) =  try await URLSession.shared.data(from: url!)
    let user = try JSONDecoder().decode([User].self, from: data)
    return user
  }
  catch{
    return []
  }
}


//async {
//  let uses = try await UserBasedOnCountry(country: "USA")
//  print(uses[0].name)
//}



//MARK: The possible suspension points in your code marked with await indicate that the current piece of code might pause execution while waiting for the asynchronous function or method to return. This is also called yielding the thread because, behind the scenes, Swift suspends the execution of your code on the current thread and runs some other code on that thread instead. Because code with await needs to be able to suspend execution, only certain places in your program can call asynchronous functions or methods:


//Code in the body of an asynchronous function, method, or property.
//Code in the static main() method of a structure, class, or enumeration that’s marked with @main.
//Code in a detached child task, as shown in Unstructured Concurrency below.






//MARK: Asynchronous Sequences
//A protocol that provides asynchronous, sequential, iterated access to its elements.

//The listPhotos(inGallery:) function in the previous section asynchronously returns the whole array at once, after all of the array’s elements are ready. Another approach is to wait for one element of the collection at a time using an asynchronous sequence. Here’s what iterating over an asynchronous sequence looks like:


let handle = FileHandle.standardInput


func AsynchronousSequence() async  {
  do{
    for try await line in handle.bytes.lines {
        print(line)
    }
  }
  catch{
    print("Something went wrong")
  }

}

//Task.init(priority: .medium, operation: {
// await AsynchronousSequence()
//})






//MARK: Calling Asynchronous Functions in Parallel
//Calling an asynchronous function with await runs only one piece of code at a time. While the asynchronous code is running, the caller waits for that code to finish before moving on to run the next line of code. For example, to fetch the first three photos from a gallery, you could await three calls to the downloadPhoto(named:) function as follows:



func downloadPhoto(named: String) async -> UIImage{
  Thread.sleep(forTimeInterval: 2)
  print(named)
  return UIImage()
}
async{
    let firstPhoto  = await  downloadPhoto(named: "photo1")
    let secondPhoto =  await downloadPhoto(named: "photo2")
    let thirdPhoto =  await downloadPhoto(named: "photo3")
  let photos =  [firstPhoto, secondPhoto, thirdPhoto]
  print(photos.description)
}


//This approach has an important drawback: Although the download is asynchronous and lets other work happen while it progresses, only one call to downloadPhoto(named:) runs at a time. Each photo downloads completely before the next one starts downloading. However, there’s no need for these operations to wait—each photo can download independently, or even at the same time.



//To call an asynchronous function and let it run in parallel with code around it, write async in front of let when you define a constant, and then write await each time you use the constant.



//async{
//    async let firstPhoto  = downloadPhoto(named: "photo1")
//    async let secondPhoto =  downloadPhoto(named: "photo2")
//    async let thirdPhoto =   downloadPhoto(named: "photo3")
//    let photos =  await [firstPhoto, secondPhoto, thirdPhoto]
//    print(photos.description)
//}


//In this example, all three calls to downloadPhoto(named:) start without waiting for the previous one to complete. If there are enough system resources available, they can run at the same time. None of these function calls are marked with await because the code doesn’t suspend to wait for the function’s result. Instead, execution continues until the line where photos is defined—at that point, the program needs the results from these asynchronous calls, so you write await to pause execution until all three photos finish downloading.


//MARK: Here’s how you can think about the differences between these two approaches:


//Call asynchronous functions with await when the code on the following lines depends on that function’s result. This creates work that is carried out sequentially.
//Call asynchronous functions with async-let when you don’t need the result until later in your code. This creates work that can be carried out in parallel.
//Both await and async-let allow other code to run while they’re suspended.
//In both cases, you mark the possible suspension point with await to indicate that execution will pause, if needed, until an asynchronous function has returned.





//MARK: Tasks and Task Groups

//A task group serves as storage for dynamically created child tasks. To create a task group, call the withTaskGroup(of:returning:body:) method.


//A task is a unit of work that can be run asynchronously as part of your program. All asynchronous code runs as part of some task. The async-let syntax described in the previous section creates a child task for you. You can also create a task group and add child tasks to that group, which gives you more control over priority and cancellation, and lets you create a dynamic number of tasks.

//
//async{
//  await withTaskGroup(of: UIImage.self) { taskGroup in
//      let photoNames = await listPhotos(inGallery: "Summer Vacation")
//      for name in photoNames {
//        taskGroup.addTask {
//          await downloadPhoto(named: name)
//        }
//      }
//  }
//}


//Each task in a task group has the same parent task, and each task can have child tasks. Because of the explicit relationship between tasks and task groups, this approach is called structured concurrency.




//MARK: Unstructured Concurrency
//In addition to the structured approaches to concurrency described in the previous sections, Swift also supports unstructured concurrency.Unlike tasks that are part of a task group, an unstructured task doesn’t have a parent task.

// You have complete flexibility to manage unstructured tasks in whatever way your program needs, but you’re also completely responsible for their correctness.

Task.init(priority: .medium) {
  
}

Task.detached(priority: .background) {

}




//MARK: Task Cancellation
//Swift concurrency uses a cooperative cancellation model. Each task checks whether it has been canceled at the appropriate points in its execution, and responds to cancellation in whatever way is appropriate.

//To check for cancellation, either call Task.checkCancellation(), which throws CancellationError if the task has been canceled, or check the value of Task.isCancelled and handle the cancellation in your own code.


//var searchTask: Task.Handle<Void, Never>?
//var findUser  = "Deepak"
//var result:[User] = []
//var searchTerm = ""
//
//for char in findUser{
//  async{
//    searchTerm = searchTerm.appending(String(char))
//    await executeQuery()
//  }
//}
//
//func executeQuery() async {
//  searchTask?.cancel()
//  let currentSearchTerm = searchTerm.trimmingCharacters(in: .whitespaces)
//  if currentSearchTerm.isEmpty {
//    result = []
//  }
//  else {
//    searchTask = async {
//      result = await listUsers(inGallery:searchTerm )
//      print(result.first?.name)
//      if !Task.isCancelled {
////        isSearching = false
//      }
//    }
//  }
//}





//MARK: Actors
// Like classes, actors are reference types. Unlike classes, actors allow only one task to access their mutable state at a time, which makes it safe for code in multiple tasks to interact with the same instance of an actor.

//Actor prevent Data races when the same memory is accessed from multiple threads without synchronization and at least one access is a write.


actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}

print("print(maxValue)")
async {
  let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
  let maxValue = await logger.max
   print(maxValue)
}

//In this example, accessing logger.max is a possible suspension point. Because the actor allows only one task at a time to access its mutable state, if code from another task is already interacting with the logger, this code suspends while it waits to access the property.





//: [Next](@next)
