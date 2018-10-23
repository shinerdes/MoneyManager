//
//  DataService.swift
//  MoneyManager
//
//  Created by 김영석 on 2018. 10. 16..
//  Copyright © 2018년 김영석. All rights reserved.
//

import Foundation
import RealmSwift

class MoneyData: Object {

    @objc dynamic var note: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var category: String = ""
    @objc dynamic var money : Int = 0
    @objc dynamic var active : String = ""

}


/*
 Note : String
 Date : NSDateFormatter() -> String
 Category : image -> String
 Money : Int
 Active : BOOL (true : imcome , false : spend)
 */

