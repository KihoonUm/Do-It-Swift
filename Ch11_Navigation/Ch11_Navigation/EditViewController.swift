//
//  EditViewController.swift
//  Ch11_Navigation
//
//  Created by Bard on 2021/08/17.
//

import UIKit

protocol EditDelegate {
    func didmessageEditDone(_ controller : EditViewController, message : String)
    func didImageOnOffDone(_ controller : EditViewController, isOn : Bool)
    func didImageZoomDone(_ controller : EditViewController, isZoom : Bool)
    }

class EditViewController: UIViewController {
    var textWayValue : String = ""
    var textMessage : String = ""
    var delegate : EditDelegate? // deoegate라는 변수 타입을 EditDelegate 프로토콜로 선언
    var isOn = false
    var isZoom = false
    
    
    @IBOutlet var lblWay: UILabel!
    @IBOutlet var txMessage: UITextField!
    @IBOutlet var swIsOn: UISwitch!
    @IBOutlet var btn_Image_Zoom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblWay.text = textWayValue
        txMessage.text = textMessage
        swIsOn.isOn = isOn
        if isZoom { // 이미지 줌의 상태가 true면 버튼의 글씨를 축소로 변경 false면 확대로 변경
            btn_Image_Zoom.setTitle("축소", for: UIControl.State())
        } else {
            btn_Image_Zoom.setTitle("확대", for: UIControl.State())
        }
    }
    
    @IBAction func btn_Done(_ sender: UIButton) {
        if delegate != nil { // delegate는 ViewController에서 정의한 delegate프로토콜문
            delegate?.didmessageEditDone(self, message: txMessage.text!) // 완료 버튼을 누르면 txMessage에서 text를 가져와 message 변수에 입력
            delegate?.didImageOnOffDone(self, isOn: isOn)
            delegate?.didImageZoomDone(self, isZoom: isZoom)
    
            
        }
        _ = navigationController?.popViewController(animated: true) // [Action Segue]를 Show형태로 했기 때문에 되돌아갈 때는 pop형태로 돌아감
        // Show 화면을 보여주고 -> pop형태로 화면을 제거
    }
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn { // 스위치의 상태가 on이면
            isOn = true // isOn변수에 true 값 대입
        } else {
            isOn = false
        }
    }
    @IBAction func btn_Image_Zoom_Action(_ sender: UIButton) {
        
        if isZoom { // isZoom 변수의 상태가 트루면
            isZoom = false // 줌의 상태를 false 로 전환후 버튼 글씨를 변경
            btn_Image_Zoom.setTitle("확대", for: UIControl.State())
        } else {
            isZoom = true
            btn_Image_Zoom.setTitle("축소", for: UIControl.State())
        }
        print(String(self.isOn)+"edit view")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
