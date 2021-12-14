//
//  ViewController.swift
//  Ch13_AVAudioPlayer_Try
//
//  Created by Bard on 2021/09/01.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    var audioPlayer : AVAudioPlayer! // AVAudioplayer 인스턴스 변수
    var audioFile : URL! // 재생할 오디오의 파일명 변수
    let MAX_VOLUME : Float = 10.0 // 볼륨 최대값
    var progressTimer : Timer! // 타이머 변수
    
    let timePlayerSelector : Selector = #selector(ViewController.updatePlayTime)
    let timeRecordSelector : Selector = #selector(ViewController.updateRecordTime)
    
    var audioRecorder : AVAudioRecorder!
    var isRecordMode = false
    
    @IBOutlet var pv_Progress_Play: UIProgressView!
    @IBOutlet var lbl_Current_Time: UILabel!
    @IBOutlet var lbl_End_Time: UILabel!
    
    @IBOutlet var btn_Play: UIButton!
    @IBOutlet var btn_Pause: UIButton!
    @IBOutlet var btn_Stop: UIButton!
    
    @IBOutlet var sl_Volume: UISlider!

    @IBOutlet var btn_Record: UIButton!
    @IBOutlet var lbl_RecordTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 모든 앱 Bundle은 앱에 대한 정보가 담긴 info.plist가 있음 -> mainBundle 앱이 실행되는 코드가 있는 Bundle 디렉토리에 접근할 수 있게 도와주는 Bundle
//        audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        // 앱에있는 자원 "Sicilian_Breeze.mp3"의 주소를 변수에 저장
        
        selectAudioFile() // 파일선택변수를 함수로 대체 // 녹음모드가아니면 기존 파일을 경로로, 녹음모드면 새로운 파일을 생성하기
        
        if !isRecordMode{ // 녹음모드가 아니면
            initPlay() // 재생함수
            btn_Record.isEnabled = false // 녹음버튼 비활
            lbl_RecordTime.isEnabled = false // 녹음시간 비활
        }else {
            initRecord() // 녹음 모드라면 녹음함수
        }
    }
    
    func selectAudioFile() {
        if !isRecordMode{ // 녹음모드가 아니면
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
            print("녹음모드가 아니다")
        }else{ // 녹음 모드일때는 새 파일인 "recodFile.m4a"가 생성
            // 사용자가 생성하는 contents는 DocumentDirectory에 저장되게 되어있음 => 저장될 Url을 위치를 변수에 저장
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a") // 저장경로에 component를 추가
            print("녹음모드")
        }
    }
    
    func initRecord() { // 녹음 실행함수
        let recordSetting = [
            AVFormatIDKey : NSNumber(value: kAudioFormatAppleLossless as UInt32), // 포맷은 'Apple Lossless'
            AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue, // 음질최대
            AVEncoderBitRateKey : 320000, // 비트율은 320kpbs
            AVNumberOfChannelsKey : 2, // 오디오 채널은 2
            AVSampleRateKey : 44100.0] as [String : Any] // 샘플률은 44100Hz
        
        do {
            audioRecorder =  try AVAudioRecorder(url: audioFile, settings: recordSetting) // 녹음파일이 없거나 세팅이 되지않았을때 에러
        } catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        audioRecorder.delegate = self // 녹음객체를 ViewController에게 권한위임
        
        sl_Volume.value = 1.0 // 볼륨슬라이더 값을 1
        audioPlayer.volume = sl_Volume.value // 오디오 볼륨도 1
        lbl_End_Time.text = convertNSTimeInterval2String(0) // 총 재생시간을 0
        lbl_Current_Time.text = convertNSTimeInterval2String(0) // 현재시간을 0
        setPlayButtons(false, false, false) // 버튼상태
        
        let session = AVAudioSession.sharedInstance() // 앱에서 오디오를 사용하는 방법을 시스템에 전달하는 개체.공유오디오세션 인스턴스 반환 메서드
        do {
            try session.setCategory(.playback, mode: .default) // 오디오세션의 범주 카테고리가 벗어낙ㄹ경우
            try session.setActive(true) // 앱의 오디오가 활성화
        } catch let error as NSError {
            print(" Error-setCategory : \(error)")
        }
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print(" Error-setActive : \(error) ")
        }
    }
    
    func initPlay()  { // 오디오파일 실행함수
        do { // play상황에서 오류발생을 처리함
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile) // 오디오 파일이 없을때 오류발생 오류없을시 오디오작동
        } catch let error as NSError { // 첫번째로 발생한 오류패턴
            print("Error-initPlay : \(error)") // AVAudioPlayer에서 지정한 오류구문 실행
        }
        
        sl_Volume.maximumValue = MAX_VOLUME // 볼륨슬라이더 최대값 지정
        sl_Volume.value = 1.0 // 볼륨 초기값 지정
        pv_Progress_Play.progress = 0 // 프로그래스뷰를 0으로 설정
        
        audioPlayer.delegate = self // 오디오객체를 ViewController에게 권한위임
        audioPlayer.prepareToPlay() // 버퍼를 미리 로드하여 재생할 오디오를 준비함 -> 호출시 오디오재생에 필요한 하드웨어를 가져오고 play함수 호출시점과 사운드출력 시작 시점사이의 지연을 최소화함
        audioPlayer.volume = sl_Volume.value
        lbl_End_Time.text = convertNSTimeInterval2String(audioPlayer.duration) // 끝나는 시간을 오디오의 시간(초)을 전달인자로보냄
        lbl_Current_Time.text = convertNSTimeInterval2String(0) // 00:00
        
//        btn_Play.isEnabled = true
//        btn_Pause.isEnabled = false
//        btn_Stop.isEnabled = false
        setPlayButtons(true, false, false) // 버튼상태 함수
    }
    
    func setPlayButtons(_ play : Bool, _ pause : Bool, _ stop : Bool) {
        btn_Play.isEnabled = play
        btn_Pause.isEnabled = pause
        btn_Stop.isEnabled = stop
    }
    
    func convertNSTimeInterval2String(_ time: TimeInterval) -> String { // 재생시간을 초기화할 함수 -> 노래의 분과,초를 String 반환함
        let min = Int(time/60) // 재생 시간의 매개변수인 time값을 60으로 나눈 '몫'을 정수 값으로 변환하여 상수 min값을 초기화
        let sec = Int(time.truncatingRemainder(dividingBy: 60)) // 시간을 60으로 나눈 나머지값을 초로반환
        let strTime = String(format: "%02d : %02d", min, sec) // 문자열의 타입을 설정하여 min(분), sec(초) 값으로 초기화
        return strTime
    }
    
    @IBAction func btn_Play_Action(_ sender: UIButton) { // 플레이버튼
        audioPlayer.play() // 오디오 시작 -> play()함수는 비동기적으로 사운드를 재생 오디오 플레이어가 재생준비가 안되었다면 암시적으로 prepareToPlay()함수 호출
        setPlayButtons(false, true, true)
        
        // 프로그래스시간에 타이머를 반환함 0.1초마다 함수를 반복함
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
    }
    
    @objc func updatePlayTime(){
        lbl_Current_Time.text = convertNSTimeInterval2String(audioPlayer.currentTime) // 오디오의 현재시간을 텍스트에 표시
        pv_Progress_Play.progress = Float(audioPlayer.currentTime/audioPlayer.duration) // 프로그래스바에 현재시간/전체시간 => 현재시간이 높아질수록 바가 채워짐
    }
    
    @IBAction func btn_Pause_Action(_ sender: UIButton) {
        audioPlayer.pause() // 오디오 일시중지 메서드
        setPlayButtons(true, false, true)
    }
    @IBAction func btn_Stop_Action(_ sender: UIButton) {
        audioPlayer.stop() // 오디오 정지메서드
        audioPlayer.currentTime = 0 // 오디오의 현재시간을 0 으로 초기화
        lbl_Current_Time.text = convertNSTimeInterval2String(0) // 라벨의 현재시간에도 0
        setPlayButtons(true, false, false)
        progressTimer.invalidate() // 타이머무효
        pv_Progress_Play.progress = 0
    }
    @IBAction func sl_Change_Volume(_ sender: UISlider) { // 볼륨조절함수
        audioPlayer.volume = sl_Volume.value // 오디오의 볼륨을 바뀐 슬라이더의 값으로 초기화
    }
    
    func audioPlayerDidFinishPlaying(_ plater : AVAudioPlayer, successfully flag : Bool) { // 오디오 재생완료 매서드
        progressTimer.invalidate() // 타이머무효화
        setPlayButtons(true, false, false) // 초기상태의 버튼
    }
    
    @IBAction func sw_RecordMode(_ sender: UISwitch) {
        if sender.isOn { // 스위치가 온상태면 오디오 기능을 전부 중지 -> 녹음기능 전부 활성화
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            lbl_RecordTime!.text = convertNSTimeInterval2String(0)
            isRecordMode = true
            btn_Record.isEnabled = true
            lbl_RecordTime.isEnabled = true
        }else{ // 스위치가 꺼진 상태면 녹음기능 전부 비활 - > 오디오기능 전부 활성화
            isRecordMode = false
            btn_Record.isEnabled = false
            lbl_RecordTime.isEnabled = false
            lbl_RecordTime.text = convertNSTimeInterval2String(0)
        }
        selectAudioFile() // 오디오파일 선택하는 함수호출 //녹음상태면 저장될 경로지정
        if !isRecordMode { // 녹음모드가 아니면 플레이 함수호출 녹음상태면 녹음함수 호출
            initPlay()
        }else{
            initRecord()
        }
    }
    
    @IBAction func btn_Record_Action(_ sender: UIButton) { // 녹음하기 버튼
        if(sender as AnyObject).titleLabel??.text == "Record"{ //버튼의 라벨이 "Record"이면
            audioRecorder.record() // 저장된 경로에 녹음하는 메서드 호출
            (sender as AnyObject).setTitle("Stop", for: UIControl.State()) // 버튼텍스트를 스탑으로바꿈
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true) // 0.1초마다 viewcontroller가 timeRecordSelector함수를 반복실행
        }else {
            audioRecorder.stop() // 녹음정지 메서드
            (sender as AnyObject).setTitle("Record", for: UIControl.State()) // 버튼텍스트를 레코드로 바꿈
            btn_Play.isEnabled = true // play 버튼 활성화
            initPlay()
        }
    }
    
    @objc func updateRecordTime() {
        lbl_RecordTime.text = convertNSTimeInterval2String(audioRecorder.currentTime) // 녹음라벨에 녹음중인 현재시간을 표시
    }
    
    
}

