//
//  Person.swift
//  RealmSample
//  Copyright © 2017 Kalyan. All rights reserved.


import UIKit
import  RealmSwift

class Person: Object {
    @objc private(set) dynamic var id = 0
    @objc private(set) dynamic var firstName = ""
    @objc private(set) dynamic var lastName = ""
    var gender = RealmOptional<Int>(0)
    var age = RealmOptional<Int>(0)

    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id : Int, firstName: String, lastName : String, age:RealmOptional<Int> , gender : RealmOptional<Int>) {
        self.init()
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.gender = gender
    }

}
