//
//  ViewController.swift
//  Ch19_PinchGesture_Quiz
//
//  Created by Bard on 2021/08/30.
//

import UIKit

let images = ["01.png", "02.png", "03.png", "04.png", "05.png", "06.png"]

class ViewController: UIViewController {

    @IBOutlet var img_View: UIImageView!
    @IBOutlet var page_Control: UIPageControl!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        page_Control.numberOfPages = images.count
        page_Control.currentPage = 0
        
        page_Control.pageIndicatorTintColor = UIColor.gray
        
        page_Control.currentPageIndicatorTintColor = UIColor.red
        
        img_View.image = UIImage(named: images[0])
        
        let swipe_Left = UISwipeGestureRecognizer(target: self, action: #selector(self.respondsToSwipeGesture(_:)))
        swipe_Left.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipe_Left)
        
        let swipe_Right = UISwipeGestureRecognizer(target: self, action: #selector(self.respondsToSwipeGesture(_:)))
        swipe_Right.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipe_Right)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
        
        
        
        
    }

    @objc func respondsToSwipeGesture(_ gesture : UIGestureRecognizer){
        
        if let swipeGseture = gesture as? UISwipeGestureRecognizer{
            
            switch swipeGseture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                if page_Control.currentPage < page_Control.numberOfPages {
                    page_Control.currentPage += 1
                    img_View.image = UIImage(named: images[page_Control.currentPage])
                }
            case UISwipeGestureRecognizer.Direction.right:
                if page_Control.currentPage > 0 {
                    page_Control.currentPage -= 1
                    img_View.image = UIImage(named: images[page_Control.currentPage])
                }
            default:
                break
            }
        }
    }
    
    @objc func doPinch(_ pinch : UIPinchGestureRecognizer){
        img_View.transform = img_View.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        pinch.scale = 1
    }
    
    @IBAction func page_Change(_ sender: UIPageControl) {
        img_View.image = UIImage(named: images[sender.currentPage])
    }
    
}

