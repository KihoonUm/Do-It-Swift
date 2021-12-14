//
//  ViewController.swift
//  Ch13_AVAudioPlayer
//
//  Created by Bard on 2021/08/20.
//

import UIKit
import AVFoundation // 오디오 재생하기 위한 헤더파일과 델리게이트 프레임워크

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var audioPlayer :AVAudioPlayer!
    var audioFile : URL!
    let MAX_VOLUME : Float = 10.0
    var progressTimer : Timer!

    let timePlayerSelector : Selector = #selector(ViewController.updatePlayTime)
    let timeRecordSelector : Selector = #selector(ViewController.updateRecordTime)

    var image : UIImage?
    
    @IBOutlet var pvProgressPlay: UIProgressView!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    @IBOutlet var btn_Play: UIButton!
    @IBOutlet var btn_Pause: UIButton!
    @IBOutlet var btn_Stop: UIButton!
    @IBOutlet var slVolume: UISlider!
    
    @IBOutlet var btn_Record: UIButton!
    @IBOutlet var lbl_RecordTime: UILabel!
    
    @IBOutlet var img_State: UIImageView!
    
    
    var audioRecorder : AVAudioRecorder!
    var isRecordMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectAudioFile()
        if !isRecordMode {
            initPlay()
            btn_Record.isEnabled = false
            lbl_RecordTime.isEnabled = false
        } else {
            initRecord()
        }
        initPlay()
        image = UIImage(named: "stop.png")
        img_State.image = image
    }
    
    func selectAudioFile() {
        if !isRecordMode {
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        } else {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
    }
    func initRecord() {
        let recordSettings = [
            AVFormatIDKey : NSNumber(value: kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey : 2,
        AVSampleRateKey : 44100.0] as [String : Any]
        
        do {
            
           audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("Error-initRecord : \(error)")
        }
        audioRecorder.delegate = self
        
        slVolume.value = 1.0
        audioPlayer.volume = slVolume.value
        lblEndTime.text = convertNSTimeInterval2String(0)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButton(false, pause: false, stop: false)
        
        let session = AVAudioSession.sharedInstance()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print(" Error-setCategory : \(error)")
        }
        do{
            try session.setActive(true)
        }catch let error as NSError {
            print(" Error-setActive : \(error)")
        }
        
    }

    func initPlay() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        slVolume.maximumValue = MAX_VOLUME
        slVolume.value = 1.0
        pvProgressPlay.progress = 0
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = slVolume.value
        lblEndTime.text = convertNSTimeInterval2String(audioPlayer.duration)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        
        setPlayButton(true, pause: false, stop: false)
        
        btn_Play.isEnabled = true
        btn_Pause.isEnabled = false
        btn_Stop.isEnabled = false
    
     
    }
    
    func setPlayButton(_ play : Bool, pause : Bool, stop : Bool)  {
        btn_Play.isEnabled = play
        btn_Pause.isEnabled = pause
        btn_Stop.isEnabled = stop
    }
    
    func convertNSTimeInterval2String(_ time:TimeInterval) -> String {
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min,sec)
        return strTime
    }
    
    @IBAction func btn_PlayAction(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButton(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
        image = UIImage(named: "play.png")
        img_State.image = image
    }
    
    @objc func updatePlayTime(){
        lblCurrentTime.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    
    @IBAction func btn_PauseAction(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButton(true, pause: false, stop: true)
        image = UIImage(named: "pause.png")
        img_State.image = image
    }


    @IBAction func btn_StopAction(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButton(true, pause: false, stop: false)
        progressTimer.invalidate()
        image = UIImage(named: "stop.png")
        img_State.image = image
    }
    
    @IBAction func sl_ChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButton(true, pause: false, stop: false)
    }
    
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            lbl_RecordTime!.text = convertNSTimeInterval2String(0)
            isRecordMode = true
            btn_Record.isEnabled = true
            lbl_RecordTime.isEnabled = true
        } else {
            isRecordMode = false
            btn_Record.isEnabled = false
            lbl_RecordTime.isEnabled = false
            lbl_RecordTime.text = convertNSTimeInterval2String(0)
        }
        selectAudioFile()
        if !isRecordMode{
            initPlay()
        }else {
            initRecord()
        }
    }
    @IBAction func btn_RecordAction(_ sender: UIButton) {
        if (sender as AnyObject).titleLabel??.text == "Record" {
            audioRecorder.record()
            (sender as AnyObject).setTitle("Stop", for: UIControl.State())
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true)
            image = UIImage(named: "record.png")
            img_State.image = image
        } else {
            audioRecorder.stop()
            progressTimer.invalidate()
            (sender as AnyObject).setTitle("Record", for: UIControl.State())
            btn_Play.isEnabled = true
            initPlay()
            image = UIImage(named: "stop.png")
            img_State.image = image
        }
      
        
    }
    @objc func updateRecordTime() {
        lbl_RecordTime.text = convertNSTimeInterval2String(audioRecorder.currentTime)
    }
}

