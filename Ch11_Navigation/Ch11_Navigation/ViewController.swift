//
//  ViewController.swift
//  Ch11_Navigation
//
//  Created by Bard on 2021/08/17.
//

import UIKit

class ViewController: UIViewController, EditDelegate { // EditViewController파일에 있는 프로토콜을 상속받아 채택함
    
    let imgOn = UIImage(named: "lamp_on.png")
    let imgOff = UIImage(named: "lamp_off.png")
    
    var isOn = true
    var isZoom = false
    var orgZoom = false
    
    @IBOutlet var txMessage: UITextField!
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.image = imgOn // 기본이미지
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {//prepare함수는 해당 세그웨이가 해당 컨트롤러로 전환되기 직전에 호출되는 함수이며 데이터 전달을 위해 사용
        // 여기서는 segue를 이용하여 화면전환을 하기 위해서 prepare 함수를 사용함
        //세그웨이 객체는 스토리보드에서 뷰 컨트롤러 사이의 연결관계, 화면전환을 관리하는 역할을 수행함
        let editViewController = segue.destination as! EditViewController // 세그의 목적지를 EditViewController로 설정함
        if segue.identifier == "editButton" { // StoryBoard의 Segue 식별자네임이 editButton이면
            editViewController.textWayValue = "segue : use button" // editviewController에 있는 textWayValue 변수에 문자열입력
        }else if segue.identifier == "editBarButton"{
            editViewController.textWayValue = "segue : use Bar button"
        }
        editViewController.textMessage = txMessage.text!
        editViewController.isOn = isOn
        editViewController.delegate = self // delegate : EditDelegate 변수에 ViewController를 대입하여 ViewController에 있는 EditDelegate구현부분을 사용
        editViewController.isZoom = orgZoom
        // 데이터들을 editViewController로 전환되기 직전에 입력함
  
    }// editViewController로 데이터를 보내는 곳
    
        
    //전달받은 메시지 값을 텍스트 필드에 표시
    func didmessageEditDone(_ controller: EditViewController, message: String) { //EditViewController.swift에 있는 프로토콜을 정의
        // 매개변수로 EditViewController타입으로 controller를 받음 -> EditViewController에서 함수를 호출하여 메시지를 전달받음 -> 수정화면의 데이터를 메인화면에 전달받아 보여주는것
        txMessage.text = message
        print("didmessageEditDone 함수")
    }// editViewController에서 데이터를 받는곳
    
    //전달받은 전구 이미지 값 세팅
    func didImageOnOffDone(_ controller : EditViewController, isOn : Bool) {
        if isOn{
            imgView.image = imgOn
            self.isOn = true
        }else {
            imgView.image = imgOff
            self.isOn = false
        }
    }
    
    //전달받은 전구이미지 확대/축소 값
    func didImageZoomDone(_ controller : EditViewController, isZoom : Bool) {
        
        let scale : CGFloat = 2.0
        var newWidth : CGFloat, newHeight : CGFloat
        
        if isZoom {
            if orgZoom {
            }else{
               // self.isZoom = false
                self.orgZoom = true
            newWidth = imgView.frame.width*scale
            newHeight = imgView.frame.height*scale
                imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            }
        }else {
            if orgZoom {
               // self.isZoom = true
                self.orgZoom = false
                newWidth = imgView.frame.width/scale
                newHeight = imgView.frame.height/scale
                imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            }
        }
    }
}


