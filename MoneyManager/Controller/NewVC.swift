//
//  NewVC.swift
//  MoneyManager
//
//  Created by 김영석 on 2018. 10. 16..
//  Copyright © 2018년 김영석. All rights reserved.
//

import UIKit
import RealmSwift

class NewVC: UIViewController, UITextFieldDelegate {
    
    let realm = try! Realm()
    var data = [MoneyData]()
    
    var accumulator: Int = 0
    
    @IBOutlet weak var moneyLbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var categorySegment: UISegmentedControl!
    @IBOutlet weak var activeControl: UISegmentedControl!

    var activeSetting = "income"
    var userInput = ""
    var buttonDis: Bool = false
    var strDate = ""
    var category = "wallet"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noteTextField.delegate = self
        todayDate()
        
        
        
        // strDate 기본 설정
        
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged) // We register the target function


        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func todayDate() {
        
        let dateFormatter = DateFormatter()
        let todaysDate = Date()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        strDate = dateFormatter.string(from: todaysDate)
    }
    
    func handleInput(str: String) {
        
        userInput += str
        
        accumulator = Int((userInput as NSString).intValue)
        updateDisplay()
    }
    
    func updateDisplay() {
        // If the value is an integer, don't show a decimal point
        
        moneyLbl.text = "$\(accumulator)"
    
    }
    
    

    func handleback() {
        
        userInput = String(userInput.dropLast())
        accumulator = Int((userInput as NSString).intValue)
        updateDisplay()
    }
    
    
    @IBAction func btn1Pressed(_ sender: Any) {
        if buttonDis == false {
            handleInput(str: "1")
        }
    }
    
    @IBAction func btn2Pressed(_ sender: Any) {
        if buttonDis == false {
            handleInput(str: "2")
        }
    }
    
    @IBAction func btn3Pressed(_ sender: Any) {
        if buttonDis == false {
            handleInput(str: "3")
        }
    }
    
    @IBAction func btn4Pressed(_ sender: Any) {
        if buttonDis == false {
            handleInput(str: "4")
        }

    }
    
    @IBAction func btn5Pressed(_ sender: Any) {
        if buttonDis == false {
            handleInput(str: "5")
        }
    }
    
    @IBAction func btn6Pressed(_ sender: Any) {
        if buttonDis == false {
            handleInput(str: "6")
        }
    }
    
    @IBAction func btn7Pressed(_ sender: Any) {
        if buttonDis == false {
            handleInput(str: "7")
        }
    }
    
    @IBAction func btn8Pressed(_ sender: Any) {
        if buttonDis == false {
            handleInput(str: "8")
        }
    }
    
    @IBAction func btn9Pressed(_ sender: Any) {
        if buttonDis == false {
            handleInput(str: "9")
        }
    }
    
    @IBAction func btn0Pressed(_ sender: Any) {
        if buttonDis == false {
            handleInput(str: "0")
        }
    }
    
    
    
    
    
    @IBAction func btnOkPressed(_ sender: Any) {
        buttonDis = true
        

        
    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
        if buttonDis == false {
            handleback()
        }
    }
    

    
    
    
    
    
    @IBAction func addBtnWasPressed(_ sender: Any) {
        
    
        if buttonDis == true {
            let test = MoneyData()
            test.note = noteTextField.text!
            test.date = strDate
            test.category = category
            test.money = Int(userInput)!
            test.active = activeSetting
        
            self.save(record: test)
            
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func save(record: MoneyData) {
        do {
            try realm.write {
                realm.add(record)
            }
        } catch {
            print("Error saving record \(error)")
        }
        
    }
    
   
    
    @IBAction func segmentActive(_ sender: Any) {
        switch activeControl.selectedSegmentIndex {
        case 0:
            activeControl.tintColor = UIColor(red: 88/255.0, green: 225/255.0, blue: 194/255.0, alpha: 1.0)
            moneyLbl.textColor = UIColor(red: 88/255.0, green: 225/255.0, blue: 194/255.0, alpha: 1.0)
            categorySegment.tintColor = UIColor(red: 88/255.0, green: 225/255.0, blue: 194/255.0, alpha: 1.0)
            activeSetting = "income"
        case 1:
            activeControl.tintColor = UIColor(red: 206/255.0, green: 10/255.0, blue: 36/255.0, alpha: 1.0)
            moneyLbl.textColor = UIColor(red: 206/255.0, green: 10/255.0, blue: 36/255.0, alpha: 1.0)
            categorySegment.tintColor = UIColor(red: 206/255.0, green: 10/255.0, blue: 36/255.0, alpha: 1.0)
            activeSetting = "expense"
        default:
            break
            
        }
    }
    @IBAction func segmentCategory(_ sender: Any) {
        
        switch categorySegment.selectedSegmentIndex {
        case 0:
            category = "wallet"
        case 1:
            category = "plane"
        case 2:
            category = "groceries"
        case 3:
            category = "dollar"
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
    @objc func datePickerChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        

        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        strDate = dateFormatter.string(from: sender.date)
        print(strDate)
    }
    
}





@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
