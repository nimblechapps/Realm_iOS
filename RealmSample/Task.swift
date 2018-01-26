//
//  Task.swift
//  RealmSample
//
//  Copyright © 2017 Kalyan. All rights reserved.


import Foundation
import RealmSwift

class Task : Object{
    @objc dynamic var name = ""
    @objc dynamic var createdAt = NSDate()
    @objc dynamic var notes = ""
    @objc dynamic var isCompleted = false
    
}
