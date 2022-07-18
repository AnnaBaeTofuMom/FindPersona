//
//  AudioManager.swift
//  FindPersona
//
//  Created by Bran on 2022/07/05.
//

import AVFoundation
import Foundation

import RxCocoa
import RxSwift

enum PlayerState {
  case playing
  case pause
  case error
}

class AudioManager {
  public static let shared = AudioManager()

  private var player: AVAudioPlayer = AVAudioPlayer()
  var state = BehaviorRelay<PlayerState>(value: .error)
  private var disposeBag = DisposeBag()

  private init() {
    setupPlayer()
    bind()
  }

  private func setupPlayer() {
    guard
      let soundAsset = NSDataAsset(name : "Til I Hear'em Say (Instrumental) - NEFFEX"),
      let player = try? AVAudioPlayer(data: soundAsset.data)
    else {
      print("Load Music Fail")
      return
    }
    self.player = player
    self.player.numberOfLoops = -1
  }

  private func bind() {
    state
      .subscribe(onNext: { [weak self] value in
        switch value {
        case .playing:
          self?.player.play()
        case .pause:
          self?.player.pause()
        case .error:
          print("Can't find Music File") // Debug Print
        }
      }).disposed(by: disposeBag)
  }
}
