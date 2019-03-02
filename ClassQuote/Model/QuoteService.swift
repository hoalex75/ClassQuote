//
//  QuoteService.swift
//  ClassQuote
//
//  Created by Alex on 01/03/2019.
//  Copyright © 2019 Alexandre Holet. All rights reserved.
//

import Foundation

class QuoteService {
    static var shared = QuoteService()
    
    private static let quoteURL = URL(string: "http://api.forismatic.com/api/1.0/")!
    private static let pictureUrl = URL(string: "https://source.unsplash.com/random/1000x1000")!
    private var task : URLSessionTask?
    
    private init(){}
    
    func getQuote(callback: @escaping (Bool, Quote?) -> Void){
        var request = URLRequest(url: QuoteService.quoteURL)
        request.httpMethod = "POST"
        let body = "method=getQuote&lang=en&format=json"
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                
                guard let responseJSON = try? JSONDecoder().decode([String:String].self, from: data),
                let author = responseJSON["quoteAuthor"],
                let quote = responseJSON["quoteText"]  else {
                    callback(false, nil)
                    return
                }
                
                self.getImage { (data) in
                    guard let data = data else {
                        callback(false, nil)
                        return
                    }
                    let quote = Quote(text: quote, author: author, imageData: data)
                    callback(true, quote)
                }
            }
        }
        task?.resume()
    }
    
    private func getImage(completionHandler: @escaping (Data?) -> Void) {
        let session = URLSession(configuration: .default)
        task?.cancel()
        task = session.dataTask(with: QuoteService.pictureUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler(nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(nil)
                    return
                }
                
                completionHandler(data)
            }
        }
        task?.resume()
    }
}
