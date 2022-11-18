//
//  BookProvider.swift
//  Listener
//
//  Created by Dongpeng Dai on 2022/7/28.
//

import Foundation
import UIKit
import CoreData

let BookKey = "Book"

class BookProvider {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllBooks() -> [Book] {
        let books = searchBooks(keyword: nil)
//        let json = JSONEncoder().encode(books)
        return books
    }
    
    func searchLikedBooks() -> [Book] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: BookKey)
        let pre = NSPredicate.init(format: "isLiked == YES")
        request.predicate = pre
        do {
            let request = try context.fetch(request)
            return request as! [Book]
        } catch  {
            print(error)
        }
        return []
    }
    
    func searchBooks(keyword: String?) -> [Book] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: BookKey)
        
        if let keyword = keyword {
//            let namePre = NSPredicate.init(format: "name CONTAINS[cd] %@", keyword)
//            let authorPre = NSPredicate.init(format: "author CONTAINS[cd] %@", keyword)
//            let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [
//                    namePre,authorPre
//                ])
            let pre = NSPredicate.init(format: "name CONTAINS[cd] %@ OR author CONTAINS[cd] %@", keyword, keyword)
            request.predicate = pre
        }
        
        do {
            let request = try context.fetch(request)
            return request as! [Book]
        } catch  {
            print(error)
        }
        return []
    }
        
    func saveBook(book: Book) {
        if let ct = book.managedObjectContext {
            try! ct.save()
        }
    }
    
    func removeOldSamples() {
        let books = getAllBooks()
        if books.first?.name == "name_1" {
            deleteAll()
        }
    }
    
    private func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Book")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
//            try myPersistentStoreCoordinator.execute(deleteRequest, with: context)
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func addSamplesIfNeeded() {
        #if DEBUG
        removeOldSamples()
        #endif
        
        let books = getAllBooks()
        guard books.count == 0 else {
            return
        }
        
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context
        
        if let filePath = Bundle.main.path(forResource: "books", ofType: "json") {
            let data = try! Data.init(contentsOf: URL.init(fileURLWithPath: filePath))
            let _ = try! decoder.decode([Book].self, from: data)
            try! context.save()
        }
        
    }
}
