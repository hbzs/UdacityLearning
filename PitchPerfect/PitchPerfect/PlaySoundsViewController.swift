//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by hourunjing on 2017/3/6.
//  Copyright © 2017年 hbzs. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
  
  // MARK: - button outlet
  
  @IBOutlet weak var snailButton: UIButton!
  @IBOutlet weak var rabbitButton: UIButton!
  @IBOutlet weak var vaderButton: UIButton!
  @IBOutlet weak var chipmunkButton: UIButton!
  @IBOutlet weak var reverbButton: UIButton!
  @IBOutlet weak var echoButton: UIButton!
  
  @IBOutlet weak var stopButton: UIButton!
  
  // MARK: -
  
  var recordedAudioURL:URL!
  var audioFile:AVAudioFile!
  var audioEngine:AVAudioEngine!
  var audioPlayerNode: AVAudioPlayerNode!
  var stopTimer: Timer!
  
  // MARK: - button type
  
  enum ButtonType: Int {
    case slow = 0, fast, vader, chipmunk, reverb, echo
  }

  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupAudio()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureUI(.notPlaying)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    stopAudio()
  }
  
  // MARK: - Button Action
  
  @IBAction func playAudioButtonClick(_ sender: UIButton) {
    configureUI(.playing)
    switch ButtonType(rawValue: sender.tag)! {
    case .slow:
      playSound(rate: 0.5)
    case .fast:
      playSound(rate: 1.5)
    case .vader:
      playSound(pitch: -1000)
    case .chipmunk:
      playSound(pitch: 1000)
    case .reverb:
      playSound(reverb: true)
    case .echo:
      playSound(echo: true)
    }
  }
  
  @IBAction func stopAudioButtonClick(_ sender: UIButton) {
    stopAudio()
  }

}
