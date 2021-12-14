//
//  ViewController.swift
//  Ch18_SwipeGesture_Quiz
//
//  Created by Bard on 2021/08/30.
//

import UIKit

var images = ["01.png", "02.png", "03.png", "04.png", "05.png", "06.png"]


class ViewController: UIViewController {

    @IBOutlet var img_View: UIImageView!
    @IBOutlet var page_Controll: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        page_Controll.numberOfPages = images.count
        page_Controll.currentPage = 0
        
        page_Controll.pageIndicatorTintColor = UIColor.green
        
        page_Controll.currentPageIndicatorTintColor = UIColor.red
        
        img_View.image = UIImage(named: images[0])
     
        let swipe_Left = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondsToSwipeGesture(_:)))
        swipe_Left.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipe_Left)
        
        let swipe_Right = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondsToSwipeGesture(_:)))
        swipe_Right.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipe_Right)
        
        
    }


    @IBAction func page_Change(_ sender: UIPageControl) {
        img_View.image = UIImage(named: images[page_Controll.currentPage])
        
    }
    
    @objc func respondsToSwipeGesture(_ gesture : UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{

            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                print(page_Controll.currentPage)
               if page_Controll.currentPage < images.count {
                    page_Controll.currentPage += 1
                print(page_Controll.currentPage)
                    img_View.image = UIImage(named: images[page_Controll.currentPage])
                }
            case UISwipeGestureRecognizer.Direction.right:
                if page_Controll.currentPage > 0 {
                    page_Controll.currentPage -= 1
                    img_View.image = UIImage(named: images[page_Controll.currentPage])
                }
            default:
                break
            }
        }
    }
}

