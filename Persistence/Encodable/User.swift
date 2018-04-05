//
//  User.swift
//  Persistence
//
//  Created by taehoon lee on 2018. 4. 3..
//  Copyright © 2018년 taehoon lee. All rights reserved.
//

import Foundation

class User: Codable, CustomStringConvertible {
    var userId: String
    var id: String
    var title: String
    var body: String
    var description: String {
        return "\(userId)(\(id)) \(title) > \(body)"
    }
    
    // customizing 이 필요하지 않다면 CodkingKeys, init(from:), encode(to:) 는 정의 및 구현하지 않아도 된다.
    private enum CodingKeys: String, CodingKey {
        case userId
        case id = "identifier"
        case title
        case body
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userId = try container.decode(String.self, forKey: .userId)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode(String.self, forKey: .body)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userId, forKey: .userId)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(body, forKey: .body)
    }
    
    init(userId: String, id: String, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}

class SubUser: User {
    var alias: String = ""
    override var description: String {
        return super.description + " " + alias
    }
    
    private enum CodingKeys: String, CodingKey {
        case alias
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        alias = try container.decode(String.self, forKey: .alias)
        
        let superDecoder = try container.superDecoder()
        try super.init(from: superDecoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(alias, forKey: .alias)
        
        let superEncoder = container.superEncoder()
        try super.encode(to: superEncoder)
    }
    
    init(userId: String, id: String, title: String, body: String, alias: String) {
        self.alias = alias
        super.init(userId: userId, id: id, title: title, body: body)
    }
}


func testCodableClass0() {
    let user = User(userId: "hoon", id: "hoon.1.user", title: "hoon's id", body: "very first user")
    print("user: \(user)")
    let jsonData = try? JSONEncoder().encode(user)
    let jsonString = String(data: jsonData!, encoding: .utf8)
    print("jsonString: \(jsonString!)")
    
    do {
        let userObject: User = try JSONDecoder().decode(User.self, from: jsonData!)
        print(userObject)
    } catch DecodingError.keyNotFound(let key, let context) {
        print("couldn't find key \(key) in JSON: \(context.debugDescription)")
    } catch DecodingError.valueNotFound(let key, let context) {
        print("couldn't find value for key \(key) in JSON: \(context.debugDescription)")
    } catch DecodingError.typeMismatch(let type, let context) {
        print("found mismatch type \(type) in JSON: \(context.debugDescription)")
    } catch DecodingError.dataCorrupted(let context) {
        print("data corrupted: \(context.debugDescription)")
    } catch {
        print("error: \(error.localizedDescription)")
    }
}

func testCodableClass1() {
    let user = SubUser(userId: "hoon", id: "hoon.1.subUser", title: "hoon's id", body: "very first subUser", alias: "subUser")
    print("user: \(user)")
    let jsonData = try? JSONEncoder().encode(user)
    let jsonString = String(data: jsonData!, encoding: .utf8)
    print("jsonString: \(jsonString!)")
    
    do {
        let userObject: SubUser = try JSONDecoder().decode(SubUser.self, from: jsonData!)
        print(userObject)
    } catch {
        print("error: \(error.localizedDescription)")
    }
}

struct MyType: Codable, CustomStringConvertible {
    var someDate: Date
    var someString: String
    var description: String {
        return "\(someDate) \(someString)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case someDate, someString
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        someDate = try container.decode(Date.self, forKey: .someDate)
        someString = try container.decode(String.self, forKey: .someString)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(someDate, forKey: .someDate)
        try container.encode(someString, forKey: .someString)
    }
    
    init(someDate: Date, someString: String) {
        self.someDate = someDate
        self.someString = someString
    }
}

struct MyType2: Codable, CustomStringConvertible {
    var someInt: Int
    var someFloat: Float
    var someIntArray: [Int]
    var description: String {
        return "\(someInt) \(someFloat) \(someIntArray)"
    }
}


func testCodableStruct0() {
    let myType = MyType(someDate: Date(), someString: "someString")
    print(myType)
    if let jsonData = try? JSONEncoder().encode(myType) {
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
            do {
                let myTypeObject: MyType = try JSONDecoder().decode(MyType.self, from: jsonData)
                print(myTypeObject)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

func testCodableStruct1() {
    let myType = MyType2(someInt: 1, someFloat: 1.0, someIntArray: [1, 2])
    print(myType)
    if let jsonData = try? JSONEncoder().encode(myType) {
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
            do {
                let myTypeObject: MyType2 = try JSONDecoder().decode(MyType2.self, from: jsonData)
                print(myTypeObject)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

