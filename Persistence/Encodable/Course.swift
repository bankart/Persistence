//
//  Book.swift
//  Persistence
//
//  Created by taehoon lee on 2018. 4. 3..
//  Copyright © 2018년 taehoon lee. All rights reserved.
//

import Foundation

// property 이름과 json data 의 key 는 대소문자가 같아야 한다.
// "https://api.letsbuildthatapp.com/jsondecodable/course"
// "https://api.letsbuildthatapp.com/jsondecodable/courses"
struct Course: Codable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
}

extension Course: CustomStringConvertible {
    var description: String {
        return "id: \(id), name: \(name), link: \(link), imageURL: \(imageUrl)"
    }
}


// "https://api.letsbuildthatapp.com/jsondecodable/website_description"
struct WebsiteDescription: Decodable {
    let name: String
    let description: String
    let courses: [Course]
}

extension WebsiteDescription: CustomDebugStringConvertible {
    var debugDescription: String {
        return "name: \(name), description: \(description), course: \(courses)"
    }
}

/*
 get test url
 https://api.letsbuildthatapp.com/jsondecodable/course
 https://api.letsbuildthatapp.com/jsondecodable/courses
 https://api.letsbuildthatapp.com/jsondecodable/website_description
 
 set test url
 https://jsonplaceholder.typicode.com/posts
 */
class CourseLoader {
    @discardableResult
    static func getCourseData() -> [Course] {
        print("\(#function)")
        var courses = [Course]()
        let jsonURLString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        guard let url = URL(string: jsonURLString) else {
            return courses
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("error: \(error!.localizedDescription)")
            } else {
                guard let data = data else {
                    print("have no received data")
                    return
                }
                
                do {
                    courses = try JSONDecoder().decode([Course].self, from: data)
                    print("courses: \(courses)")
                } catch {
                    print("new version > error: \(error.localizedDescription)")
                }
            }
        }.resume()
        return courses
    }
    
    @discardableResult
    static func getWebsiteDescription() -> WebsiteDescription? {
        print("\(#function)")
        var description: WebsiteDescription?
        guard let url = URL(string: "https://api.letsbuildthatapp.com/jsondecodable/website_description") else {
            return description
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("connection error: \(error!.localizedDescription)")
            } else {
                guard let data = data else {
                    return
                }
                do {
                    description = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                    print("description!.name: \(description!.name), description!.courses: \(description!.courses)")
                } catch {
                    print("parsing error: \(error.localizedDescription)")
                }
            }
        }
        return description
    }
}


