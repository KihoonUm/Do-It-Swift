//
//  ViewController.swift
//  Ch19_PinchGesture
//
//  Created by Bard on 2021/08/30.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var imgPinch: UIImageView!
    
    var inintialFontSize : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:)))
        self.view.addGestureRecognizer(pinch)
    }
    @objc func doPinch(_ pinch : UIPinchGestureRecognizer) {
        imgPinch.transform = imgPinch.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        pinch.scale = 1
    }
    


}

