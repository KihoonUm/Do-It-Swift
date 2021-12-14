//
//  ViewController.swift
//  Ch5_PickerView
//
//  Created by Bard on 2021/08/11.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let MAX_ARRAY_NUM = 10
    let PICKER_VIEW_COLUMN = 2
    var imageArray = [UIImage?]()
    let PICKER_VIEW_HEIGHT:CGFloat = 80
    
    
    var imageFileName = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg",
                         "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg", ]

    @IBOutlet var pickerImage: UIPickerView!
    @IBOutlet var lbl_ImageFileName: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerImage.delegate = self
        pickerImage.dataSource = self
        
        for i in 0 ..< MAX_ARRAY_NUM {
            let image = UIImage(named: imageFileName[i])
            imageArray.append(image)
        }
        lbl_ImageFileName.text = imageFileName[0]
        imageView.image = imageArray[0]
    
    }

    func numberOfComponents(in pickerView : UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return PICKER_VIEW_HEIGHT
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component : Int) -> Int {
        return imageFileName.count
    }
    
//    func pickerView(_ pickerView : UIPickerView, titleForRow row : Int, forComponent component : Int) -> String? {
//        return imageFileName[row]
//    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
        let imageView = UIImageView(image: imageArray[row])
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        return imageView
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if component == 0 {
            lbl_ImageFileName.text = imageFileName[row]
        }else {
            imageView.image = imageArray[row]
        }
            
    }

}
