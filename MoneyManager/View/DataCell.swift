//
//  DataCell.swift
//  MoneyManager
//
//  Created by 김영석 on 2018. 10. 21..
//  Copyright © 2018년 김영석. All rights reserved.
//

import UIKit
import RealmSwift

class DataCell: UITableViewCell {
    
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var noteLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var moneyLbl: UILabel!
    
    
    func configureCell(category: UIImage, note: String, date: String, money: Int, active: String){
        self.categoryImage.image = category
        self.noteLbl.text = note
        self.dateLbl.text = date
        self.moneyLbl.text = String(money)
        
        if active == "income" {
            self.moneyLbl.textColor = UIColor.init(red: 54/255, green: 206/255, blue: 144/255, alpha: 1)
        } else {
            self.moneyLbl.textColor = UIColor.init(red: 222/255, green: 43/255, blue: 63/255, alpha: 1)
            
        }
        
    }


}
