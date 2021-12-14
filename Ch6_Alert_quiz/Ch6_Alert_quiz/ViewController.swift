//
//  ViewController.swift
//  Ch6_Alert_quiz
//
//  Created by Bard on 2021/08/12.
//

import UIKit

class ViewController: UIViewController {
    
    let timeSelector : Selector = #selector(ViewController.updateTime)
    let interval = 1.0
    var alarmTime : String?
    var alertFlag = false
    
    
    @IBOutlet var lbl_Current_Time: UILabel!
    @IBOutlet var lbl_Picker_Time: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func datePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        lbl_Picker_Time.text = "선택시간 : " + formatter.string(from: datePickerView.date)
        formatter.dateFormat = "HH:mm"
        alarmTime = formatter.string(from: datePickerView.date)

    }

    @objc func updateTime(){
        let date = NSDate()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        
        lbl_Current_Time.text = "현재시간 : " + formatter.string(from: date as Date)
        
        formatter.dateFormat = "HH:mm"
        
        let currentTime = formatter.string(from: date as Date)
        if alarmTime == currentTime{
            if !alertFlag {
                let alarmAlert = UIAlertController(title: "알림", message: "설정된 시간입니다 !!!", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "네, 알겠습니다.", style: UIAlertAction.Style.default, handler: nil)
                alarmAlert.addAction(okAction)
                present(alarmAlert, animated: true, completion: nil)
                alertFlag = true
            }
        }else{
            alertFlag = false
        }
      
        
    }
}

