//
//  TasksViewController.swift
//  RealmSample
//
//  Copyright © 2017 Kalyan. All rights reserved.


import UIKit
import Realm
import RealmSwift

class TasksViewController: UIViewController {

    let realm = try? Realm()

    var lists : Results<TaskList>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let taskListA = TaskList()
        taskListA.name = "TasksToDo"
        
        let t1 = Task()
        t1.name = "Morning Walk"
        t1.notes = "At 6 AM every day"
        
        let t2 = Task(value: ["name": "BreakFast", "notes": "Pancakes every Monday"])
        let t3 = Task(value: ["Car", NSDate(), "Auto R8", false])
        
        taskListA.tasks.append(objectsIn: [t1, t2, t3])
        

        try? realm!.write ({
            realm?.add([taskListA,taskListA])
        })
            lists = realm?.objects(TaskList.self)

            print(lists)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
