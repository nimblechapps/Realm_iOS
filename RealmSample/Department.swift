//
//  Department.swift
//  RealmSample
//  Copyright © 2017 Kalyan. All rights reserved.


import UIKit
import RealmSwift

class Department: Object {
    
//    let realm = try! Realm(configuration: config) // Invoke migration block if needed

    @objc private(set) dynamic var id = 0
    @objc private(set) dynamic var departmentName = ""
    @objc private(set) dynamic var personDesignation = ""

   // private(set) dynamic var personDesig = ""

    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
    
    convenience init(id : Int, departmentName: String, personDesignation : String) {
        self.init()
        self.id = id
        self.departmentName = departmentName
        self.personDesignation = personDesignation
    }

}
