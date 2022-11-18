//
//  APIManager.swift
//  Listener
//
//

import Foundation
import UIKit

class APIManager {

    func register(email: String, password: String, completion: @escaping (_ message: String) -> ()) {
        registerOrLogin(email: email, password: password, isRegister: true, completion: completion)
    }
    
    func login(email: String, password: String, completion: @escaping (_ message: String) -> ()) {
        registerOrLogin(email: email, password: password, isRegister: false, completion: completion)
    }
    
    func getAllBooks(callback: @escaping (_ books: [Book]) -> ()) {
        let req = createRequest(path: "all_books.php")
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            var results: [Book] = []
            if let data = data {
                do {
//                    let books = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! Array<Book>
//                    results = books
                    let decoder = JSONDecoder()
                    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                    decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context
                    if let r = try? decoder.decode([Book].self, from: data){
                        results = r
                    }
                } catch  {
                    print(error)
                }
            }
            
            callback(results)
            
        }.resume()
    }
    
    private func createRequest(path: String) -> URLRequest {
        var request = URLRequest(url: URL(string: "http://39.106.8.65:13366/v2/\(path)")!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 5
        return request
    }
    
    private func registerOrLogin(email: String, password: String, isRegister: Bool,completion: @escaping (_ message: String) -> ()) {
        var request = createRequest(path: isRegister ? "register.php" : "login.php")
        var urlComponents = URLComponents()
        urlComponents.queryItems = [
            URLQueryItem(name: "email", value: email),
            URLQueryItem(name: "password", value: password)]

        request.httpBody = urlComponents.percentEncodedQuery?.data(using: .utf8)
    
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            var message = "Server Error."
            if let data = data {
                do {
                    let dic = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! Dictionary<String, Any>
                    message = dic["message"] as! String
                } catch  {
                    print(error.localizedDescription)
                    completion(message)
                }
            }
            
            completion(message)
        }.resume()
    }
    
    
}
