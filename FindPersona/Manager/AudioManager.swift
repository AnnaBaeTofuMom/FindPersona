//
//  AudioManager.swift
//  FindPersona
//
//  Created by Bran on 2022/07/05.
//

import AVFoundation
import UIKit

class AudioManager: NSObject {
  public static let shared = AudioManager()
  private var player: AVAudioPlayer?
  private var isPlaying: Bool = false

  private override init() {
    super.init()
    self.setupPlayer()
  }

  private func setupPlayer() {
    guard
      let soundAsset = NSDataAsset(name : "Til I Hear'em Say (Instrumental) - NEFFEX") // TODO: - R.Swift 적용필요
    else {
      print("음원없음")
      return
    }
    do {
      try self.player = AVAudioPlayer(data: soundAsset.data)
      self.player?.delegate = self
    } catch let error as NSError {
      print("Player Error", error)
    }
  }

  func playOrPause() {
    switch self.isPlaying {
    case false:
      self.player?.play()
    case true:
      self.player?.stop()
    }
    self.isPlaying.toggle()
  }

}

extension AudioManager: AVAudioPlayerDelegate {
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    self.player?.stop()
    self.player?.currentTime = TimeInterval(0.0)
    self.player?.play()
  }
}
