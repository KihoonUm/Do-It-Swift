//
//  ViewController.swift
//  Ch18_SwipeGesture
//
//  Created by Bard on 2021/08/27.
//

import UIKit

class ViewController: UIViewController {
    let numOfTouchs = 2

    @IBOutlet var imgView_Up: UIImageView!
    @IBOutlet var imgView_Down: UIImageView!
    @IBOutlet var imgView_Left: UIImageView!
    @IBOutlet var imgView_Right: UIImageView!
    
    var img_Up = [UIImage]() // UIImage 형태로 배열로 만듦
    var img_Down = [UIImage]()
    var img_Left = [UIImage]()
    var img_Rigth = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 이미지배열에 이미지 추가
        img_Up.append(UIImage(named: "arrow-up-black.png")!)
        img_Up.append(UIImage(named: "arrow-up-red.png")!)
        img_Up.append(UIImage(named: "arrow-up-green.png")!)
        img_Down.append(UIImage(named: "arrow-down-black.png")!)
        img_Down.append(UIImage(named: "arrow-down-red.png")!)
        img_Down.append(UIImage(named: "arrow-down-green.png")!)
        img_Left.append(UIImage(named: "arrow-left-black.png")!)
        img_Left.append(UIImage(named: "arrow-left-red.png")!)
        img_Left.append(UIImage(named: "arrow-left-green.png")!)
        img_Rigth.append(UIImage(named: "arrow-right-black.png")!)
        img_Rigth.append(UIImage(named: "arrow-right-red.png")!)
        img_Rigth.append(UIImage(named: "arrow-right-green.png")!)
        // 기본이미지는 0
        imgView_Up.image = img_Up[0]
        imgView_Down.image = img_Down[0]
        imgView_Left.image = img_Left[0]
        imgView_Right.image = img_Rigth[0]
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action:  #selector(ViewController.respondToSwipeGesture(_:))) // 인스턴스 생성 target - action 디자인패턴
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up // 방향을 up
//        swipeUp.numberOfTouchesRequired = numOfTouchs // 멀티 제스쳐
        self.view.addGestureRecognizer(swipeUp) // 뷰에 제스쳐 인스턴스 붙임
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
//        swipeDown.numberOfTouchesRequired = numOfTouchs // 멀티제스처
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//        swipeLeft.numberOfTouchesRequired = numOfTouchs // 멀티제스쳐
        self.view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
//        swipeRight.numberOfTouchesRequired = numOfTouchs // 멀티제스쳐
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUpMulti = UISwipeGestureRecognizer(target: self, action:  #selector(ViewController.respondToSwipeGestureMulti(_:)))
        swipeUpMulti.direction = UISwipeGestureRecognizer.Direction.up // 멀티제스처 위에방향
        swipeUpMulti.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeUpMulti)
        
        let swipeDownMulti = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGestureMulti(_:)))
        swipeDownMulti.direction = UISwipeGestureRecognizer.Direction.down
        swipeDownMulti.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeDownMulti)
        
        let swipeLeftMulti = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGestureMulti(_:)))
        swipeLeftMulti.direction = UISwipeGestureRecognizer.Direction.left
        swipeLeftMulti.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeLeftMulti)
        
        let swipeRightMulti = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGestureMulti(_:)))
        swipeRightMulti.direction = UISwipeGestureRecognizer.Direction.right
        swipeRightMulti.numberOfTouchesRequired = numOfTouchs
        self.view.addGestureRecognizer(swipeRightMulti)
        
        
    }

    @objc func respondToSwipeGesture(_ gesture : UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            imgView_Up.image = img_Up[0]
            imgView_Down.image = img_Down[0]
            imgView_Left.image = img_Left[0]
            imgView_Right.image = img_Rigth[0]
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.up:
                imgView_Up.image = img_Up[1]
            case UISwipeGestureRecognizer.Direction.down:
                imgView_Down.image = img_Down[1]
            case UISwipeGestureRecognizer.Direction.left:
                imgView_Left.image = img_Left[1]
            case UISwipeGestureRecognizer.Direction.right:
                imgView_Right.image = img_Rigth[1]
            default:
                break
                
            }
        }
    }

    @objc func respondToSwipeGestureMulti(_ gesture : UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            imgView_Up.image = img_Up[0]
            imgView_Down.image = img_Down[0]
            imgView_Left.image = img_Left[0]
            imgView_Right.image = img_Rigth[0]
            
            switch swipeGesture.direction { // 방향이 찾기
            case UISwipeGestureRecognizer.Direction.up:
                imgView_Up.image = img_Up[2]
            case UISwipeGestureRecognizer.Direction.down:
                imgView_Down.image = img_Down[2]
            case UISwipeGestureRecognizer.Direction.left:
                imgView_Left.image = img_Left[2]
            case UISwipeGestureRecognizer.Direction.right:
                imgView_Right.image = img_Rigth[2]
            default:
                break
            }
        }
    }
}

