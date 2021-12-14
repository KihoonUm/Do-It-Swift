//
//  TableViewController.swift
//  Ch12_TableViewController
//
//  Created by Bard on 2021/08/18.
//

import UIKit

var items = ["책 구매", "철수와 약속", "스터디 준비하기"]
var itemsImageFile = ["cart.png", "clock.png", "pencil.png"]

class TableViewController: UITableViewController {

    @IBOutlet var tvListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem // 테이블컨트롤러에 왼쪽에 editButton추가 (UIKit)
    }
    
    override func viewWillAppear(_ animated: Bool) { // 뷰가 다시 호출될때 => 리스트가 추가되어 지금의 뷰로 돌아올때 호출됨
        tvListView.reloadData() // 호출될때 추가된 내용을 새로고침
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 // 테이블 안에 섹션이 한 개이므로 리턴값을 1로줌 -> 섹션이란 하나의 리스트
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count // 섹션당 행의 개수는 Items의 개수
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 셀의 이미지와 텍스트 설정함수
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) // 스토리보드에서 설정한 식별자

        cell.textLabel?.text = items[(indexPath as NSIndexPath).row] // 셀의 텍스트레이블에 앞에 선언한 items배열의 값
        cell.imageView?.image = UIImage(named: itemsImageFile[(indexPath as NSIndexPath).row]) // 셀의 이미지 뷰에 앞에선언한 이미지 대입
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { // 테이블뷰 행삭제
            // Delete the row from the data source
            items.remove(at: (indexPath as NSIndexPath).row)
            itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제" // 테이블뷰 삭제 text반환 함수
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) { //테이블을 이동하는 함수
        let itemToMove = items[(fromIndexPath as NSIndexPath).row] // 이동할 아이템의 위치를 itemToMove에 저장
        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row] // 이동할 아이템의 이미지를 itemImageToMove에 저장
        items.remove(at: (fromIndexPath as NSIndexPath).row) // 이동할 아이템 삭제 => 삭제뒤에 인덱스 재정렬
        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row) // => 이동할 아이템의 이미지 삭제 => 삭제뒤에 인덱스 재정렬
        items.insert(itemToMove, at: (to as NSIndexPath).row) // => 삭제된 아이템을 이동할 위치로 삽입 => 삽입뒤에 인덱스 재정렬
        itemsImageFile.insert(itemImageToMove, at: (to as NSIndexPath).row) // => 삭제된 아이템의 이미지를 이동할 위치로 삽입 => 삽입뒤에 인덱스 재정렬
    }
    
    
    // MARK: - Navigation

    // 세그웨이를 이용하여 뷰를 이동하는 함수
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // DetailViewContoller로 화면전환 메서드
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgDetail" { // segue 식별자확인
        let cell = sender as! UITableViewCell // 다운캐스팅하여 tebleViewCell 타입으로 테이블뷰의 셀의 정보
            let indexPath = self.tvListView.indexPath(for: cell) // 테이블뷰의 선택된 인덱스위치
            let detailView = segue.destination as! DetailViewController // 뷰의 도착지 DetailViewController로감
            detailView.receiveItem(items[((indexPath! as NSIndexPath).row)]) // 디테일뷰콘트롤러에 있는 reciveItem함수에 값전달
        }
        
    }
    

}
