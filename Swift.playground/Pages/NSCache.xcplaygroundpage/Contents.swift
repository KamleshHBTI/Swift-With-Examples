//: [Previous](@previous)

import Foundation

////MARK: Cache
//final class Cache<Key:Hashable, Value>{
//  private let wrapped = NSCache<WrappedKey, Entry>()
//
//  func insert(_ value: Value, forKey key: Key){
//    wrapped.setObject(Entry(value: value), forKey: WrappedKey(key))
//  }
//
//  func value(forKey key: Key)-> Value?{
//    let entry = wrapped.object(forKey: WrappedKey(key))
//    return entry?.value
//  }
//  
//  func removeValue(forKey key: Key){
//    wrapped.removeObject(forKey: WrappedKey(key))
//  }
//}
//
////MARK: Cache Key
//
//private extension Cache{
//  final class WrappedKey: NSObject{
//    let key: Key
//
//    init(_ key: Key ) { self.key = key }
//
//    override var hash : Int {return key.hashValue}
//
//    override func isEqual(_ object: Any?) -> Bool {
//      guard let value = object as? WrappedKey else {
//        return false
//      }
//      return value.key == key
//    }
//  }
//}
//
////MARK: Cache Value
//
//private extension Cache {
//  final class Entry {
//    let value: Value
//
//    init(value: Value) {
//      self.value = value
//    }
//  }
//}
//
////MARK: Cache Subscript
//
//extension Cache{
//  subscript(key: Key) -> Value?
//  get {return value(forKey: key)}
//  set{
//    guard let value = newValue else{
//      removeValue(forKey: key)
//    }
//    insert(value, forKey: key)
//  }
//}
//
//class ArticleLoader {
//    typealias Handler = (Result<Article, Error>) -> Void
//
//    private let cache = Cache<Article.ID, Article>()
//
//    func loadArticle(withID id: Article.ID,
//                     then handler: @escaping Handler) {
//        if let cached = cache[id] {
//            return handler(.success(cached))
//        }
//
//        performLoading { [weak self] result in
//            let article = try? result.get()
//            article.map { self?.cache[id] = $0 }
//            handler(result)
//        }
//    }
//}

struct Article{
  typealias ID = Double
}

//: [Next](@next)
