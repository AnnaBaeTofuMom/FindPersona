//
//  SettingViewModel.swift
//  FindPersona
//
//  Created by Bran on 2022/07/18.
//

import Foundation

import RxCocoa
import RxSwift

final class SettingViewModel: ViewModelType {
  var disposeBag = DisposeBag()

  struct Input {
    let talkButtonTapped = PublishRelay<Void>()
    let musicState = AudioManager.shared.state
    let musicButtonTapped = PublishRelay<Void>()
    let shareButtonTapped = PublishRelay<Void>()
  }

  struct Output {
    let pushDevView: Driver<String> // TODO: -
    let actionSheetView: Driver<String> // TODO: -
  }

  var input: Input = Input()

  func transform() -> Output {
    let pushDevView = input.talkButtonTapped
      .map { "talkButton Tapped" }
      .asDriver(onErrorJustReturn: "Error")

    let actionSheetView = input.shareButtonTapped
      .map { "shareButton Tapped" }
      .asDriver(onErrorJustReturn: "Error")

    return Output(pushDevView: pushDevView, actionSheetView: actionSheetView)
  }
}
