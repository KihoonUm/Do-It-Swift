//
//  ViewController.swift
//  Ch2_ImageView_Quiz_retry
//
//  Created by Bard on 2021/08/11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var btn_Before: UIButton!
    @IBOutlet var btn_After: UIButton!
    
    var numImage : Int = 1
    let min_Num = 1
    let max_Num = 6
    
    
    var img : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        img = UIImage(named: "1.png")
        imgView.image = img
        
    }
    
    
    @IBAction func btn_Before_Action(_ sender: UIButton) {
        numImage = numImage - 1
        if numImage < min_Num {
            numImage = 1
        }
        let imageName = String(numImage) + ".png"
        img = UIImage(named: imageName)
        imgView.image = img
        
    }
    
    @IBAction func btn_After_Action(_ sender: UIButton) {
        numImage = numImage + 1
        
        if numImage > max_Num {
            numImage = max_Num
        }
        let imageName = String(numImage) + ".png"
        img = UIImage(named: imageName)
        imgView.image = img
        
    
    }
}

