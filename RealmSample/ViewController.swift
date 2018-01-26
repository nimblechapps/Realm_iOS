//
//  ViewController.swift
//  RealmSample
//  Copyright © 2017 Kalyan. All rights reserved.



import UIKit
import Realm
import RealmSwift

class ViewController: UIViewController {
    
    let realmManager = RealmManager()
    var personsArr  = [Person]()
    let realm = try? Realm()

    var genderArr = ["Male","Female"]

    @IBOutlet var personsTableView: UITableView!
    @IBAction func addBarButtonAction(_ sender: UIBarButtonItem) {
        
        let addVc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        addVc.isEditingData = false

        self.navigationController?.pushViewController(addVc, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.retrieveDataBasedOnID(id: 1)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        personsArr = [Person]()
        getAllObjects()
        self.personsTableView.reloadData()
    }
    
    // fetch all the objects in table
    func getAllObjects() {
        personsArr = [Person]()
        if let objects = realmManager.getObjects(type: Person.self) {
            for element in objects {
                if let person = element as? Person {
                    // Do whatever you like with 'person' object
//                    print("\(person.firstName), \(person.id), \(person.age)")
                    personsArr.append(person)
                }
            }
        }
    }
    
    // retreive data based on userid
    func retrieveDataBasedOnID(id : Int) {
        
        let personScope = realm?.objects(Person.self).filter("id == %@", id)
        let person = personScope?.first
//        print("email is",person?.email ?? "")
//        print("name is",person?.firstName ?? "")
//        print("last name is",person?.lastName ?? "")
//        print("department is",person?.departmentId ?? 0)
        
//        let deptScope = realm?.objects(Department.self).filter("id == %@", person?.departmentId ?? 0)
//        let dept = deptScope?.first
//       // print("personName is",dept?.personDesignation ?? "")
//        print("personName is",dept?.departmentName ?? "")
        
        
    }
    
}

extension ViewController : UITableViewDelegate ,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cellID")
        let person = personsArr[indexPath.row]
        var gender = ""
        var age :Int = 0
        if let ag = person.age.value {
            age = ag
        }

        if let gen = person.gender.value {
            gender = genderArr[gen]
        }
        
        
        cell.textLabel?.text = String.init(format: "%@ %@",person.firstName ,person.lastName)
        if age == 0 {
            cell.detailTextLabel?.text = String.init(format: "%@",gender)
        } else {
            cell.detailTextLabel?.text = String.init(format: "%d %@",age ,gender)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            tableView.beginUpdates()
            let person : Person = personsArr[indexPath.row]
            // delete an Object
            realmManager.deleteObject(objs: person)
            personsArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath],  with: UITableViewRowAnimation.automatic)
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let addVc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        addVc.personData = personsArr[indexPath.row]
        addVc.isEditingData = true
        self.navigationController?.pushViewController(addVc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//extension ViewController {
//    //Returs an array as Results<object>?
//    func getObjects(type: Object.Type) -> Results<Object>? {
//        return realm.objects(type)
//    }
//    
//    
//    func deleteDatabase() {
//        try! realm.write({
//            realm.deleteAll()
//        })
//    }
//    
//    // delete particular object
//    func deleteObject(objs : Object) {
//        try! realm.write ({
//            realm.delete(objs)
//        })
//    }
//    
//
//}











