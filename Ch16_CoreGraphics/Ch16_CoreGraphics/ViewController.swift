//
//  ViewController.swift
//  Ch16_CoreGraphics
//
//  Created by Bard on 2021/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btn_DrawLine(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imageView.frame.size)//비트맵 기반 그래픽 컨텍스트를 작성하여 현재 컨텍스트로 만듦 -> 이미지뷰크기
        let context = UIGraphicsGetCurrentContext()! // 생성한 콘텍스트의 정보를 가져옴
        // context : 컨텐츠를 담을 무엇 -> context 도화지
        context.setLineWidth(2.0) // 콘텍스트에 선의 굵기
        context.setStrokeColor(UIColor.red.cgColor) // 선의색깔
        
        context.move(to: CGPoint(x : 0, y : 0)) // 선의 초기점
        context.addLine(to: CGPoint(x: 270, y: 250)) // 선이 이동할 지점
        
        context.strokePath() // 추가한 지점을 콘텍스트에 그림
        
        context.setLineWidth(4.0)
        context.setStrokeColor(UIColor.blue.cgColor)
        
        context.move(to: CGPoint(x: 170, y: 200))
        context.addLine(to: CGPoint(x: 270, y: 350))
        context.addLine(to: CGPoint(x: 70, y: 350))
        context.addLine(to: CGPoint(x: 170, y: 200))
   
        context.strokePath()
        imageView.image = UIGraphicsGetImageFromCurrentImageContext() // 이미지뷰에 현재 콘테스트에 그려진 이미지를 입력
        UIGraphicsEndImageContext() // 그립그리기 종료
    }
    @IBAction func btn_Rectangle(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)
        
        context.addRect(CGRect(x: 70, y: 100, width: 200, height: 200))
        context.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    @IBAction func btn_Circle(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)
        
        context.addEllipse(in: CGRect(x: 70, y: 50, width: 200, height: 100)) // 타원을 그리는 함수 -> 좌표 70,50에서 시작하고 넓이 200 높이 100인 사각형 안에 내접하는 타원을 그림
        context.strokePath()
        
        context.setLineWidth(5.0)
        context.setStrokeColor(UIColor.green.cgColor)
        
        context.addEllipse(in: CGRect(x: 70, y: 200, width: 200, height: 200))
        context.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func btn_Arc(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(5.0)
        context.setStrokeColor(UIColor.red.cgColor)
        
        context.move(to: CGPoint(x: 100, y: 50))
        context.addArc(tangent1End: CGPoint(x: 250, y: 50), tangent2End: CGPoint(x: 250, y: 200), radius: CGFloat(50)) // 현재위치에서 두 개의 접점 사이에 내접한 반지름 50인 호를 그리는 함수
        context.addLine(to: CGPoint(x: 250, y: 200))
        
        context.move(to: CGPoint(x: 100, y: 250))
        context.addArc(tangent1End: CGPoint(x: 270, y: 250), tangent2End: CGPoint(x: 100, y: 400), radius: CGFloat(20))
        context.addLine(to: CGPoint(x: 100, y: 400))
        
        context.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func btn_Fill(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.red.cgColor)
        context.setFillColor(UIColor.red.cgColor)
        
        let rectangle = CGRect(x: 70, y: 50, width: 200, height: 100)
        context.addRect(rectangle)
        context.fill(rectangle) // 사각형의 내부를 색상으로 채움
        context.strokePath()
        
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setFillColor(UIColor.blue.cgColor)
        
        let circle = CGRect(x: 70, y: 200, width: 200, height: 100)
        context.addEllipse(in: circle)
        context.fillEllipse(in: circle)// 원, 타원의 내부를 블루로 채움
        context.strokePath()
        
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.green.cgColor) // 선의색을 지정
        context.setFillColor(UIColor.green.cgColor) //채울 색을 지정
        
        context.move(to: CGPoint(x: 170, y: 350))
        context.addLine(to: CGPoint(x: 270, y: 450))
        context.addLine(to: CGPoint(x: 70, y: 450))
        context.addLine(to: CGPoint(x: 170, y: 350))
        context.fillPath()
        context.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext() //이미지뷰에 표시
        UIGraphicsEndImageContext()//콘텍스트 종료
    }
    
}

