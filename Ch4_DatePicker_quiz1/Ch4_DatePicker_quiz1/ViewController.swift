//
//  ViewController.swift
//  Ch4_DatePicker_quiz1
//
//  Created by Bard on 2021/08/10.
//

import UIKit

class ViewController: UIViewController {

    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval = 1.0
    var count = 0
    var alarmTime = String()
    
    
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblSelectTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        lblSelectTime.text = "선택시간 : " + formatter.string(from: datePickerView.date)
        formatter.dateFormat = "HH:mm"
        alarmTime = formatter.string(from: datePickerView.date)
        
    }
    
    @objc func updateTime(){
        
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblCurrentTime.text = "현재시간 : " + formatter.string(from: date as Date)
        
        formatter.dateFormat = "HH:mm"
        let currentTime = formatter.string(from: date as Date)
        if alarmTime == currentTime {
            view.backgroundColor = UIColor.green
        }
        else{
            view.backgroundColor = UIColor.white
        }
    }
}

