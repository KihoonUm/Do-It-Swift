//
//  ViewController.swift
//  Ch17_Sketch
//
//  Created by Bard on 2021/08/27.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var text_TextSIze: UITextField!
    
    var lastPoint : CGPoint!
    var lineSize : CGFloat = 2.0
    var lineColor = UIColor.red.cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func clearImageView(_ sender: UIButton) {
        imgView.image = nil
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // 터치 시작때 호출
        let touch = touches.first! as UITouch
        lastPoint = touch.location(in: imgView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { // 터치상태에서 움직이면 호출
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        let touch = touches.first! as UITouch // 현재 발생한 터ㅣ 이벤트를 가지고 옴
        let currPoint = touch.location(in: imgView) // 터치된 위치를 currPoint로 가지고 옴
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height)) // 현재 이미지 뷰에 있는 이미지를 이미지 뷰의 크기로 그림
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // 이전에 이동된 위치인 lastPoint로 시작 위치를 이동
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y)) // lastPoint에서 현재위치인 currPoint까지 선을 추가
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPoint = currPoint // 현재 터치된 위치를 lastPoint라는 변수에 할당
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { // 터치끝나면 호출
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(20)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height)) // 현재 이미지 뷰에 있는 이미지를 이미지 뷰의 크기로 그림
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // 이전에 이동된 위치인 lastPoint로 시작 위치를 이동
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // lastPoint에서 현재위치인 currPoint까지 선을 추가
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) { // 기기흔들고나서 호출됨
        if motion == .motionShake {
            imgView.image = nil // 이미지뷰 비우기
        }
    }
    
    @IBAction func btn_LineBlack(_ sender: UIButton) {
        if text_TextSIze.text != nil, text_TextSIze.text != ""{
            lineSize = CGFloat(Int(text_TextSIze.text!)!)
        }
        lineColor = UIColor.black.cgColor
    }
    @IBAction func btn_LineRed(_ sender: UIButton) {
        if text_TextSIze.text != nil, text_TextSIze.text != ""{
            lineSize = CGFloat(Int(text_TextSIze.text!)!)
        }
        lineColor = UIColor.red.cgColor
    }
    @IBAction func btn_LineGreen(_ sender: UIButton) {
        if text_TextSIze.text != nil, text_TextSIze.text != ""{
            lineSize = CGFloat(Int(text_TextSIze.text!)!)
        }
        lineColor = UIColor.green.cgColor
    }
    @IBAction func btn_LineBlue(_ sender: UIButton) {
        if text_TextSIze.text != nil, text_TextSIze.text != ""{
            lineSize = CGFloat(Int(text_TextSIze.text!)!)
        }
        lineColor = UIColor.blue.cgColor
    }
    
    
}

