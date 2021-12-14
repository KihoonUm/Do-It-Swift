//
//  ViewController.swift
//  Ch2_ImageView
//
//  Created by Bard on 2021/08/06.
//

import UIKit

class ImageViewController: UIViewController {
    
    var isZoom = false
    var imgOn: UIImage?
    var imgOff : UIImage?
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var btnResize: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgOn = UIImage(named: "lamp_on.png")
        imgOff = UIImage(named: "lamp_off.png")
        
        imgView.image = imgOn
    }

    @IBAction func btnResizeImage(_ sender: UIButton) {
        let scale : CGFloat = 2.0
        var newWidth : CGFloat, newHeight : CGFloat
        
        if isZoom { //isZoom 값이 true
            newWidth = imgView.frame.width/scale // 넓이 곱하기 2
            newHeight = imgView.frame.height/scale // 높이 곱하기 2
            btnResize.setTitle("확대", for: .normal)
        }else{ // isZoom 값이 false
            newWidth = imgView.frame.width*scale //넓이 곱하기2
            newHeight = imgView.frame.height*scale // 높이 곱하기2
            btnResize.setTitle("축소", for: .normal)
        }
        imgView.frame.size = CGSize(width: newWidth, height: newHeight) // 이미지뷰의 이미지틀.크기 조절
        isZoom = !isZoom //현재 isZoom값에서 반대로 설정
        
    }
    
    @IBAction func switchImageOnOff(_ sender: UISwitch) {
        if sender.isOn { // switch 내장된 변수값이 on이면 on이미지로 아니면 off이미지로
            imgView.image = imgOn
        }else{
            imgView.image = imgOff
        }
    }
}

