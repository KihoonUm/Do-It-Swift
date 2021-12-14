//
//  ViewController.swift
//  Ch9_PageControl_Quiz
//
//  Created by Bard on 2021/08/17.
//

import UIKit

var numbers: [Int] = [1,2,3,4,5,6,7,8,9,10]


class ViewController: UIViewController {

    @IBOutlet var lbl_PageNumber: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControl.numberOfPages = numbers.count
        pageControl.currentPage = 0
        
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.green
        lbl_PageNumber.text = String(numbers[0])
    }


    @IBAction func pageChange(_ sender: UIPageControl) {
        lbl_PageNumber.text = String(numbers[pageControl.currentPage])
    }
}

