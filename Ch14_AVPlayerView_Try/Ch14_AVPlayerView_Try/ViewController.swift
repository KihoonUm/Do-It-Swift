//
//  ViewController.swift
//  Ch14_AVPlayerView_Try
//
//  Created by Bard on 2021/09/01.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btn_PlayInternalMOvie(_ sender: UIButton) { // 내부파일 비디오재생
        let filePath : String? = Bundle.main.path(forResource: "FastTyping", ofType: "mp4") // 비디오가 저장된 내부의 파일경로르 받아옴
        let url = NSURL(fileURLWithPath: filePath!) // NSURL형태로 형변환
        playVideo(url: url)
//        let playerController = AVPlayerViewController() // AVPlayerViewControlㅣer -> 플레이어 콘텐츠를 표시하고 재생을 제어하는 기본 사용자 인터페이스를 제공하는 뷰 컨트롤러
//
//        let player = AVPlayer(url: url as URL) // AVPlayer -> 플레이어의 전송동작을 제어하는 인터페이스를 제공하는 개체 -> 위에서 만든 Url로 초기화된 AVPlayer -> 다리역할
//        playerController.player = player // player 속성에 위에서 초기화한 player 인스턴스 할당
//
//        self.present(playerController, animated: true){ // 비디오 팝업창(다이얼로그)
//            player.play() // 재생
//        }
        
    }
    @IBAction func btn_PlayExternalMovie(_ sender: UIButton) { // 외부파일 비디오재생
        let url = NSURL(string: "https://dl.dropboxusercontent.com/s/e38auz050w2mvud/Fireworks.mp4")!
        playVideo(url: url)
//        let playerController = AVPlayerViewController()
//
//        let player = AVPlayer(url: url as URL)
//        playerController.player = player
//
//        self.present(playerController, animated: true){
//            player.play()
//        }
        
    }
    private func playVideo(url : NSURL){
        let playerController = AVPlayerViewController() // AVPlayerViewControlㅣer -> 플레이어 콘텐츠를 표시하고 재생을 제어하는 기본 사용자 인터페이스를 제공하는 뷰 컨트롤러
        
        let player = AVPlayer(url: url as URL) // AVPlayer -> 플레이어의 전송동작을 제어하는 인터페이스를 제공하는 개체 -> 위에서 만든 Url로 초기화된 AVPlayer -> 다리역할
        playerController.player = player // player 속성에 위에서 초기화한 player 인스턴스 할당
        
        self.present(playerController, animated: true){ // 비디오 팝업창(다이얼로그)
            player.play() // 재생
        }
    }
    
}

