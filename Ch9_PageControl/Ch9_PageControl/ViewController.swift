//
//  ViewController.swift
//  Ch9_PageControl
//
//  Created by Bard on 2021/08/17.
//

import UIKit

var images = ["01.png", "02.png", "03.png", "04.png", "05.png", "06.png"] // 이미지의 이름들

class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView! // 이미지뷰의 아웃렛변수
    @IBOutlet var pageControl: UIPageControl! // 페이지 컨트롤러의 아웃렛변수
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pageControl.numberOfPages = images.count // 페이지컨트롤의 전체 페이지수 => 6개로 할당
        pageControl.currentPage = 0 // 현재페이지는 0
        pageControl.pageIndicatorTintColor = UIColor.green // 페이지컨트롤의 페이지 표시하는 부분의 색상
        pageControl.currentPageIndicatorTintColor = UIColor.red // 페이지컨트롤의 현재 보여지는 페이지 표시의 색상
        imgView.image = UIImage(named: images[0]) // 이미지뷰에 이미지 할당 01.png

    }


    @IBAction func pageChange(_ sender: UIPageControl) { //페이지컨트롤의 액션함수
        imgView.image = UIImage(named: images[pageControl.currentPage])
        // 이미지뷰의 이미지에 UIImage타입의 이미지를 페이지 컨트롤의 현재페이지에서 가져와 할당함
    }
}

