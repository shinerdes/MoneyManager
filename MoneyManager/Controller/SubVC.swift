//
//  SubVC.swift
//  MoneyManager
//
//  Created by 김영석 on 2018. 10. 16..
//  Copyright © 2018년 김영석. All rights reserved.
//

import UIKit

class SubVC: UIViewController {
    
    @IBOutlet weak var goToMainBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        goToMainBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60

    }
    
    
    
    

}
