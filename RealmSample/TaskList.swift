//
//  TaskList.swift
//  RealmSample
//
//  Copyright © 2017 Kalyan. All rights reserved.


import Foundation
import RealmSwift

class TaskList: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var createdAt = NSDate()
    let tasks = List<Task>()
    
}

