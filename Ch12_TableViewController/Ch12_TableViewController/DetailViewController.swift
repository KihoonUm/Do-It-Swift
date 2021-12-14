//
//  DetailViewController.swift
//  Ch12_TableViewController
//
//  Created by Bard on 2021/08/18.
//

import UIKit

class DetailViewController: UIViewController {
    
    var receiveItem = ""
    

    @IBOutlet var lbl_Item: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lbl_Item.text = receiveItem
    }

    func receiveItem(_ item : String){ // 전달받은 변수를 받기위한 함수
        receiveItem = item
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
