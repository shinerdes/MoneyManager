//
//  ViewController.swift
//  MoneyManager
//
//  Created by 김영석 on 2018. 10. 15..
//  Copyright © 2018년 김영석. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lineChart: LineChartView!
    
    
    // money collect
    
    var totalMoney = 2000 //원래 있던 돈 + balanceMoney
    var incomeMoney = 0
    var expenseMoney = 0
    var balanceMoney = 0

    //
    
    var monMoney = 0
    var tuesMoney = 0
    var wedMoney = 0
    var thuMoney = 0
    var friMoney = 0
    var satMoney = 0
    var sunMoney = 0
    
    // realm
    
    let realm = try! Realm()
    // realm data
    
    var realmDataCount = 0
    
    var data = try! Realm().objects(MoneyData.self).sorted(byKeyPath: "date", ascending: false)
    var incomeData: Results<MoneyData>?
    var expenseData: Results<MoneyData>?
    
    // outlet
    
    @IBOutlet weak var goToSubBtn: UIButton!
    @IBOutlet weak var mainVCLbl: UILabel!
    
    
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var incomeLbl: UILabel!
    @IBOutlet weak var expenseLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        

        goToSubBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        

        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        
        moneyResult()
        dayOfTheWeekMoney()
        
        let dollars1 = [monMoney, tuesMoney, wedMoney, thuMoney, friMoney, satMoney, sunMoney]
        let months = ["월", "화", "수", "목", "금", "토", "일"]
        var yValues : [ChartDataEntry] = [ChartDataEntry]()
        
        for i in 0 ..< months.count {
            yValues.append(ChartDataEntry(x: Double(i + 1), y: Double(dollars1[i])))
        }
        
        let data = LineChartData()
        let ds = LineChartDataSet(values: yValues, label: "요일")
        
        data.addDataSet(ds)
        self.lineChart.data = data
        self.lineChart.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.lineChart.gridBackgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.lineChart.isExclusiveTouch = false
        
        
       
    }
    
   
    func moneyResult() { // 정산
        
        let income = NSPredicate(format: "active = 'income'")
        let expense = NSPredicate(format: "active = 'expense'")

        incomeData = realm.objects(MoneyData.self).filter(income).sorted(byKeyPath: "date") // 수입에 대한 array
        expenseData = realm.objects(MoneyData.self).filter(expense).sorted(byKeyPath: "date") // 지출에 대한 array
        incomeMoney = realm.objects(MoneyData.self).filter(income).sum(ofProperty: "money")
        expenseMoney = realm.objects(MoneyData.self).filter(expense).sum(ofProperty: "money")
       
        balanceMoney = incomeMoney - expenseMoney
        totalMoney = totalMoney + incomeMoney - expenseMoney
       
        incomeLbl.text = "$\(incomeMoney)"
        expenseLbl.text = "$\(expenseMoney)"
        balanceLbl.text = "$\(balanceMoney)"
        overviewLbl.text = "$\(totalMoney)"
        
        if balanceMoney >= 0 {
            balanceLbl.textColor = UIColor(red: 71/255, green: 177/255, blue: 212/255, alpha: 1)
        } else {
            
            balanceLbl.textColor = UIColor(red: 238/255, green: 30/255, blue: 68/255, alpha: 1)
            
        }
        
        totalMoney = 2000
    }
    
    func dayOfTheWeekMoney() {
        monMoney = 0
        tuesMoney = 0
        wedMoney = 0
        thuMoney = 0
        friMoney = 0
        satMoney = 0
        sunMoney = 0
        
        
        
        for i in 0..<(data.count){
            let info = data[i]
            let returnDay = getWeekDay(atYear: Int(info.date.split(separator: "/")[2])!, atMonth: Int(info.date.split(separator: "/")[1])!, atDay: Int(info.date.split(separator: "/")[0])!)
            switch returnDay {
                case "월":
                    if info.active == "income" {
                        monMoney = monMoney + info.money
                    } else {
                        monMoney = monMoney - info.money
                    }
                case "화":
                    if info.active == "income" {
                        tuesMoney = tuesMoney + info.money
                    } else {
                        tuesMoney = tuesMoney - info.money
                    }
                
                case "수":
                    if info.active == "income" {
                        wedMoney = wedMoney + info.money
                    } else {
                        wedMoney = wedMoney - info.money
                    }
                
                case "목":
                    if info.active == "income" {
                        thuMoney = thuMoney + info.money
                    } else {
                        thuMoney = thuMoney - info.money
                    }
                
                case "금":
                    if info.active == "income" {
                        friMoney = friMoney + info.money
                    } else {
                        friMoney = friMoney - info.money
                    }
                
                case "토":
                    if info.active == "income" {
                        satMoney = satMoney + info.money
                    } else {
                        satMoney = satMoney - info.money
                    }
                
                case "일":
                    if info.active == "income" {
                        sunMoney = sunMoney + info.money
                    } else {
                        sunMoney = sunMoney - info.money
                    }
                
                default:
                    break
                
            }
            
            
            
        }
      
        
        
    }
    
    
    
    
    
    
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell") as? DataCell else { return UITableViewCell() }
        
        let info = data[indexPath.row]
        
        cell.configureCell(category: UIImage(named: info.category)!, note: info.note, date: info.date, money: info.money, active: info.active)
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        } else {
            cell.backgroundColor = UIColor.white
        }
       
        
        return cell
    }
    
    func lineChartUpdate() {
      
   
     
        
    }
    
    func getVisitorCountsFromDatabase() -> Results<MoneyData> {
        do {
            let realm = try Realm()
            return realm.objects(MoneyData.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    

    
    
    
    
    
    
    
    
    
    ///////////////////
    
    
    func checkLeap(year: Int) -> Bool { // 윤년 구하기
        var checkValue: Bool = false
        if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0){
            checkValue = true
        }else {
            checkValue = false
        }
        return checkValue
    }
    
    func endDayOfMonth(year: Int, month: Int) -> Int {
        
        var endDay: Int = 0
        let inputMonth: Int = month
        
        let monA: Set = [1,3,5,7,8,10,12]
        let monB: Set = [4,6,9,11]
        
        if monA.contains(inputMonth)  {
            endDay = 31
        }else if monB.contains(inputMonth) {
            endDay = 30
        }
        
        if inputMonth == 2 {
            if checkLeap(year: year) {
                endDay = 29
            }else {
                endDay = 28
            }
        }
        return endDay
    }
    
    func getWeekDay(atYear:Int, atMonth:Int, atDay:Int) -> String {
        
        var dayDay:[String] = ["월", "화", "수", "목", "금", "토", "일"]
        var returnValue: String = ""
        var totalDay: Int = 0
        
        for i in 1..<atMonth {
            totalDay += endDayOfMonth(year: atYear, month: i)
        }
        
        var index: Int = 0
        if (totalDay + atDay) % 7 == 0 {
            index = 6
        }else {
            index = (totalDay + atDay) % 7 - 1
        }
        
        returnValue = dayDay[index]
        
        return "\(returnValue)"
        
    }
    
    

    
 
}


