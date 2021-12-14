//
//  ViewController.swift
//  Ch15_CameraPhoto_Library
//
//  Created by Bard on 2021/08/23.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var imgView: UIImageView!
    
    let imagePicker : UIImagePickerController! = UIImagePickerController()
    // UIImagePickerContoller 사용자의 미디어 라이브러리에서 사진 촬영, 동영상 녹화 및 항목 선택을 위한 시스템 인터페이스를 관리하는 뷰 컨트롤러
    var captureImage : UIImage!
    var videoURL : URL!
    var flagImageSave = false // 이미지 저장 여부를 나타낼 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_Captureimage_FromCamera(_ sender: UIButton) { // 카메라 촬영버튼
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) { // 카메라의 사용가능 여부를 확인
            flagImageSave = true // 카메라 촬영 후 저장할 것이기 때문에 이미지 저장을 허용
            
            imagePicker.delegate = self // 권한위임
            imagePicker.sourceType = .camera // 사용할 타입 케이스는 카메라
            imagePicker.mediaTypes = [kUTTypeImage as String] // 미디어타입설정
            imagePicker.allowsEditing = false // 편집허용하지 않음
            
            present(imagePicker, animated: true, completion: nil)// imagePicker 팝업창을 띄움
        }
        else{
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    
    @IBAction func btn_Captureimage_FromeLibrary(_ sender: UIButton) { // 갤러리파일에서 이미지가져오기
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) { // 포토라이브러리권한 사용 여부 확인
            flagImageSave = false // 이미지저장 불가
            
            imagePicker.delegate = self // 권한위임
            imagePicker.sourceType = .photoLibrary // 사용할 타입은 사진갤러리
            imagePicker.mediaTypes = [kUTTypeImage as String] // 미디어의 타입은 이미지
            imagePicker.allowsEditing = true // 편집을 허용함
            
            present(imagePicker, animated: true, completion: nil)
        }
        else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album.")
        }
    }
    
    @IBAction func btn_RecordVideo_FromCamera(_ sender: UIButton) { // 비디오촬영버튼
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) { // 카메라 촬영 버튼에대한 권한확인
            flagImageSave = true // 저장 가능
            
            imagePicker.delegate = self // 권한위임
            imagePicker.sourceType = .camera // 사용할타입은 카메라
            imagePicker.mediaTypes = [kUTTypeMovie as String] // 미디어타입은 영상
            imagePicker.allowsEditing = false // 편집 불가능
            
            present(imagePicker, animated: true, completion: nil)
            
        }
        else{
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    
    @IBAction func btn_LoadVideo_FromLibrary(_ sender: UIButton) { // 비디오 갤러리 버튼
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) { // 갤러리 접근가능 여부확인
            flagImageSave = false // 저장 불가
            
            imagePicker.delegate = self // 권한위임
            imagePicker.sourceType = .photoLibrary // 사용할타입은 라이브러리
            imagePicker.mediaTypes = [kUTTypeMovie as String] // 미디어타입은 영상
            imagePicker.allowsEditing = false // 편집불가능
            
            present(imagePicker, animated: true, completion: nil)
        }
        else{
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album.")
        }
    }
    
    // 미디어 선택을 끝났을 때 호출되는 메서드
    func imagePickerController(_ picker : UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString // 미디어 종류확인
        
        
        if mediaType.isEqual(kUTTypeImage as NSString as String) { // 이미지일경우
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage // 사진을 가져와 저장
            if flagImageSave { // 저장가능 여부
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil) // 앨범에 저장
            }
            imgView.image = captureImage //표시할 이미지를 가져온 이미지로
        }else if mediaType.isEqual(kUTTypeMovie as NSString as String){ // 영상일경우
            if flagImageSave { // 저장가능여부
                videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL) // 촬영한 비디오의 주소를 저장
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil) // 앨범에 촬영비디오 저장
            }
        }
        self.dismiss(animated: true, completion: nil) // 현재 표시되는 뷰컨트롤러 제거 -> 첫화면으로
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {// 사용자가imagePicker에서 취소를 눌렀을때
        self.dismiss(animated: true, completion: nil) // 뷰컨트롤러 제거
    }
    
    func myAlert(_ title : String, message: String) { // 경고표시용 알람창
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert) // 알람창 생성
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil ) // 알람버튼생성
        alert.addAction(action) // 알람창에 버튼추가
        self.present(alert, animated: true, completion: nil) // viewcontroller위에 알람팝업을 띄움
    }
}

