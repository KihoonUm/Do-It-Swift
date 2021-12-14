//
//  AddViewController.swift
//  Ch12_TableViewController
//
//  Created by Bard on 2021/08/18.
//

import UIKit

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var tfAddItem: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var picker_Image: UIPickerView!
    
    let MAX_ARRAY_NUM = 3
    let PICKER_VIEW_COLUMN = 1
    var image_Icon = ["cart.png", "clock.png", "pencil.png"]
    var imageArray = [UIImage?]()
    var append_Image : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for i in 0 ..< MAX_ARRAY_NUM{
            let image = UIImage(named: image_Icon[i])
            imageArray.append(image)
        }
        imageView.image = imageArray[0]
        append_Image = image_Icon[0]
    }
    
    @IBAction func btn_AddItem(_ sender: UIButton) {
        items.append(tfAddItem.text!) // items에 텍스트 필드의 텍스트값을 추가 => 메인뷰에있는 배열
        itemsImageFile.append(append_Image) // items에 텍스트 이미지 추가 => 메인뷰에있는 배열
        tfAddItem.text="" // textfield 내용지움
        _ = navigationController?.popViewController(animated: true) // 현재 보여지는 창을 pop하여 닫음
    }
    
    func numberOfComponents(in pickerView : UIPickerView) -> Int { //피켜뷰에 선택가능 리스트 수 = > 여기선 1개 => 열의개수
        return PICKER_VIEW_COLUMN
    }

    func pickerView(_ pickerView : UIPickerView, numberOfRowsInComponent component : Int) -> Int { // 행의개수
        return image_Icon.count // 피커뷰에 표시될 항목의 개수
    }
    func pickerView(_ pickerView : UIPickerView, titleForRow row : Int, forComponent component : Int) -> String? {
        return image_Icon[row] // 피커뷰 내에서 특정위치를 가르킬때 그 위치에 해당하는 문자열을 반환
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        imageView.image = imageArray[row] // 피커뷰에서 특정 row가 선택되었을때 행동
        append_Image = image_Icon[row] // append_image 문자열에 이미지파일 이름 입력
    }
   

}
