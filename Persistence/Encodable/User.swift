//
//  User.swift
//  Persistence
//
//  Created by taehoon lee on 2018. 4. 3..
//  Copyright © 2018년 taehoon lee. All rights reserved.
//

import Foundation

class User {
    var userId: String
    var id: String
    var title: String
    var body: String
    
    init(userId: String, id: String, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}


//class UserDataLoader {
//    static func getData() -> [User] {
//        var datas = [User]()
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
//            print("url(https://jsonplaceholder.typicode.com/posts) is invalid")
//            return datas
//        }
//        var request = URLRequest(url: url, cachePolicy: .returnCacheDataDontLoad, timeoutInterval: 5.0)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        let urlSession = URLSession.shared.dataTask(with: request) { (jsonData, response, error) in
//            print("response: \(response.debugDescription)")
//            if error != nil {
//                print("error: \(error!.localizedDescription)")
//            } else {
//                let convertedData = JSONSerialization()
//            }
//        }
//        return datas
//    }
//}
