//
//  ViewController.swift
//  Ch4_DatePicker
//
//  Created by Bard on 2021/08/09.
//

import UIKit

class DateViewController: UIViewController {

    let timeSelector: Selector = #selector(DateViewController.updateTime)// 타이머 구동시 실행될 함수
    let interval = 1.0
    var count = 0
    
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblPickerTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true) // 타이머설정 -> 초당흐르는시간, 실행할뷰, 실행할함수, 유저정보, 반복여부
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender // 선택한 날짜 표시
        
        let formatter = DateFormatter() // 날짜형식 인스턴스생성
        formatter.dateFormat = "YY-MM-dd HH:mm EEE" // 날짜형식 지정
        lblPickerTime.text = "선택시간 : " + formatter.string(from: datePickerView.date) //라벨에 날짜형식에 선택한날짜를 대입하여 표시
        
    }
 
    @objc func updateTime(){//타이머함수
//        lblCurrentTime.text = String(count)
//        count = count + 1
        
        let date = NSDate() // date받아오기
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblCurrentTime.text = "현재시간 : " + formatter.string(from: date as Date) 
    }
    
    
}

