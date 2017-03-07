//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by hourunjing on 2017/3/6.
//  Copyright © 2017年 hbzs. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
  
  struct Infos {
    static let StopRecordSegueIdentifier   = "stopRecordSegue"
    
    static let RecordFailureInfo           = "record unsuccessfully"
    static let RecordingInfo               = "Recording in Progress"
    static let ToRecordInfo                = "Tap to Record"
    
    static let RecordName                  = "audioVoice.wav"
    static let Separator                   = "/"
  }

  @IBOutlet weak var recordButton: UIButton!
  @IBOutlet weak var recordInfoLabel: UILabel!
  @IBOutlet weak var stopButton: UIButton!
  
  var audioRecorder: AVAudioRecorder!
  
  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    configureUI(false)
  }
  
    // MARK: - Action
  
  @IBAction func record(_ sender: AnyObject) {
    configureUI(true)
    
    let audioSession = AVAudioSession.sharedInstance()
    try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
    
    try! audioRecorder = AVAudioRecorder(url: self.audioFilePath(), settings: [ : ])
    audioRecorder.delegate = self
    audioRecorder.isMeteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
  }
  
  @IBAction func saveAndProcessRecord(_ sender: AnyObject) {
    configureUI(false)
    
    audioRecorder.stop()
  }
  
  // MARK: - AVAudioRecorderDelegate
  
  func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    if flag {
      performSegue(withIdentifier: Infos.StopRecordSegueIdentifier, sender: recorder.url)
    } else {
      print(Infos.RecordFailureInfo)
    }
  }
  
  // MARK: - Navigation

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Infos.StopRecordSegueIdentifier {
      let playSoundsViewController = segue.destination as! PlaySoundsViewController
      playSoundsViewController.recordedAudioURL = sender as! URL
    }
  }
  
  // MARK: - UI change
  
  func configureUI(_ isRecording: Bool) {
    recordButton.isEnabled = !isRecording
    stopButton.isEnabled   =  isRecording
    recordInfoLabel.text   =  isRecording ? Infos.RecordingInfo : Infos.ToRecordInfo
  }
  
  // MARK: - Helper Method
  
  func audioFilePath() -> URL {
    let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let recordName   = Infos.RecordName
    let paths        = [documentPath, recordName]
    let fullPath     = URL(string: paths.joined(separator: Infos.Separator))
    
    return fullPath!
  }

}
