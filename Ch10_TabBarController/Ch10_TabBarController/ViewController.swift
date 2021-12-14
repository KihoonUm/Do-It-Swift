//
//  ViewController.swift
//  Ch10_TabBarController
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
        tabBarController?.selectedIndex = 1 // 탭바 컨트롤러의 index 번호 1로 이동
    }
    @IBAction func btnMoveDatePickerView(_ sender: UIButton) {
        tabBarController?.selectedIndex = 2 // 탭바 컨트롤의 index 번호 2로 이동
    }
    
}

