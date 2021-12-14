//
//  ViewController.swift
//  Ch10_TabBarController_Quiz
//
//  Created by Bard on 2021/08/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func btnMoveImageView(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
    }
    @IBAction func btn_MoveDatePikerView(_ sender: UIButton) {
        tabBarController?.selectedIndex = 2
    }
    
}

