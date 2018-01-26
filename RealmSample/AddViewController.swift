//
//  AddViewController.swift
//  RealmSample
//  Copyright © 2017 Kalyan. All rights reserved.



import UIKit
import RealmSwift
import Realm

class AddViewController: UIViewController {
    
    var person = [Person]()
    let realm = try? Realm()
    let realmManager = RealmManager()
    var personData : Person?
    var isEditingData : Bool = false
    var genderArr = ["Male","Female"]
    let pickerView = UIPickerView()
    var activeTextField: UITextField!
    var lists : Results<TaskList>!

    
    @IBOutlet var lastNameTf: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var firstNameTf: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        if firstNameTf.text?.count == 0 && lastNameTf.text?.count == 0 && ageTF.text?.count == 0 && genderTF.text?.count == 0 {
            showAlert()
            return
        }
        addPersons()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        // Do any additional setup after loading the view.
        firstNameTf.text = personData?.firstName ?? ""
        lastNameTf.text = personData?.lastName ?? ""
        if let age = personData?.age.value {
                ageTF.text =  String(describing: age)
        }
        if let gender = personData?.gender.value {
                genderTF.text = genderArr[gender]
        }
        pickerView.delegate = self
        pickerView.dataSource = self
        genderTF.inputView = pickerView
        setToolBar()
        
        
        /// Get realm path
        
        if let fileUrl = Realm.Configuration.defaultConfiguration.fileURL{
            print("FILE URL IS",fileUrl)
        }

        
        /// LIST
        
        let taskListA = TaskList()
        taskListA.name = "Wishlist"
        
        let wish1 = Task()
        wish1.name = "iPhone6s"
        wish1.notes = "64 GB, Gold"
    
        
        let wish2 = Task(value: ["name": "Game Console", "notes": "Playstation 4, 1 TB"])
        let wish3 = Task(value: ["Car", NSDate(), "Auto R8", false])
        
        taskListA.tasks.append(objectsIn: [wish1, wish2, wish3])
        
        let taskListB = TaskList()
        taskListB.name = "Wishlist"
        
        
        taskListB.tasks.append(objectsIn: [wish1, wish2, wish3])
        
        try? realm!.write ({
            realm?.add([taskListA,taskListB])
        })
        lists = realm?.objects(TaskList.self)
        
        print(lists)
        
//        print(lists[0].tasks[0].name)

        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert() {
        let alertController = UIAlertController.init(title: "", message: "Enter your details" , preferredStyle: .alert)
        let logoutAction = UIAlertAction.init(title: "Ok", style: .default) { (action) in
        }
        alertController.addAction(logoutAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func addPersons() {
        
        // Editing the existing object
        let age = Int(ageTF.text!)
        let gender = genderArr.index(of: genderTF.text!)
        
        if isEditingData == true {
            let newPerson = Person(id : (personData?.id)! , firstName : firstNameTf.text ?? "" , lastName : lastNameTf.text ?? "" ,age:RealmOptional<Int>(age) ,gender : RealmOptional<Int>(gender))
            realmManager.editObjects(objs: newPerson)
        }
            // Adding the new Object
        else if isEditingData == false {
            let id = realmManager.incrementID()
            let newPerson = Person(id : id , firstName : firstNameTf.text ?? "" , lastName : lastNameTf.text ?? "" ,age:RealmOptional<Int>(age),gender: RealmOptional<Int>(gender))
            realmManager.saveObjects(objs: newPerson)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setToolBar() {
        
        let toolBar = UIToolbar.init()
        toolBar.barStyle = .default
        toolBar.frame = CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width, height: 44)
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneClicked))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        genderTF.inputAccessoryView = toolBar
        ageTF.inputAccessoryView = toolBar
        
    }
    
    @objc func doneClicked() {
        if (activeTextField == ageTF) {
            genderTF.becomeFirstResponder()
        } else {
            let str : String = genderArr[self.pickerView.selectedRow(inComponent: 0)]
            genderTF.text = str
            genderTF.resignFirstResponder()
        }
    }
    
    
}

extension AddViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTf {
            lastNameTf.becomeFirstResponder()
        } else if textField == lastNameTf {
            ageTF.becomeFirstResponder()
        } else if textField == ageTF {
            genderTF.becomeFirstResponder()
        } else{
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
}

extension AddViewController :UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderArr.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTF.text = genderArr[row]
    }
    
    
}









