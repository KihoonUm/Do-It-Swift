//
//  ViewController.swift
//  Ch17_TabTouch
//
//  Created by Bard on 2021/08/27.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var txtMessage: UILabel!
    @IBOutlet var txtTapCount: UILabel!
    @IBOutlet var txtTouchCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { // 터치가 시작될 때 호출
        let touch = touches.first! as UITouch // 현재 발생한 터치 이벤트를 가지고옴
        txtMessage.text = "Touches Began" // 메서드에서 현재 발생한 이벤트의 종류를 출력
        txtTapCount.text = String(touch.tapCount) // touches 세트 안에 포함된 터치의 개수를 출력
        txtTouchCount.text = String(touches.count) // 터치 객체들 중 첫 번째 객체에서 탭의 개수를 가져와 출력
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) { // 터치된 손가락이 움직였을 때 호출
        let touch = touches.first! as UITouch
        
        txtMessage.text = "Touches Moved"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) { // 화면에서 손가락을 떼었을 때 호출
        let touch = touches.first! as UITouch
        
        txtMessage.text = "Touches End"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)

        

    }

}

