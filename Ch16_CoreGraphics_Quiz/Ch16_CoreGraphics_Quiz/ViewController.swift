//
//  ViewController.swift
//  Ch16_CoreGraphics_Quiz
//
//  Created by Bard on 2021/08/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageVIew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    
    }

    @IBAction func btn_Flower_Draw(_ sender: UIButton) {
        
        UIGraphicsBeginImageContext(imageVIew.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(4.0)
        context.setStrokeColor(UIColor.green.cgColor)
        context.setFillColor(UIColor.green.cgColor)
        
        context.move(to: CGPoint(x: 170, y: 200))
        context.addLine(to: CGPoint(x: 200, y: 450))
        context.addLine(to: CGPoint(x: 140, y: 450))
        context.addLine(to: CGPoint(x: 170, y: 200))
        context.fillPath()
        context.strokePath()
        
        
        circle_Draw(context: context, x: 120, y: 150)
        circle_Draw(context: context, x: 120+50, y: 150)
        circle_Draw(context: context, x: 120-50, y: 150)
        circle_Draw(context: context, x: 120, y: 150-50)
        circle_Draw(context: context, x: 120, y: 150+50)
        
        imageVIew.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    
    @IBAction func btn_Reset(_ sender: UIButton) {
        imageVIew.image = nil
    }
    
    
    func circle_Draw(context : CGContext! ,x : Int, y : Int) {

        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.blue.cgColor)
        
        let circle = CGRect(x: x, y: y, width: 100, height: 100)
        context.addEllipse(in: circle)
        context.strokePath()

    }
}

