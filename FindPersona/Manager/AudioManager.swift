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
  case unknwon
}

class AudioManager {
  public static let shared = AudioManager()

  private var player: AVAudioPlayer = AVAudioPlayer()
  var state = BehaviorRelay<PlayerState>(value: .unknwon)
  var disposeBag = DisposeBag()

  private init() {
    setupPlayer()
    bind()
  }

  private func setupPlayer() {
    guard
      let soundAsset = NSDataAsset(name : "Til I Hear'em Say (Instrumental) - NEFFEX")
    else {
      print("Load Music Fail")
      return
    }
    do {
      try player = AVAudioPlayer(data: soundAsset.data)
      player.numberOfLoops = -1
    } catch let error as NSError {
      print("Player Error", error)
    }
  }

  private func bind() {
    state
      .subscribe(onNext: { [weak self] value in
        switch value {
        case .playing:
          self?.player.play()
        case .pause:
          self?.player.pause()
        case .unknwon:
          print("Can't find Music File")
        }
      })
      .disposed(by: disposeBag)
  }

  func play() {
    state.accept(.playing)
  }

  func stop() {
    state.accept(.pause)
  }
}
