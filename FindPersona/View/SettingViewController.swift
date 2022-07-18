//
//  SettingViewController.swift
//  FindPersona
//
//  Created by Bran on 2022/07/17.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class SettingViewController: UIViewController, ViewType {
  typealias ViewModel = SettingViewModel

  var viewModel: SettingViewModel
  var disposeBag: DisposeBag

  private let titleLabel = UILabel() // MARK: - "Hi,"
  private let subLabel = UILabel() // MARK: - "Name,"
  private let characterButton = UIButton()
  private let editLabel = UILabel()
  private let talkButton = UIButton()
  private let musicButton = UIButton()
  private let shareButton = UIButton()

  init(viewModel: ViewModel) {
      self.viewModel = viewModel
      self.disposeBag = DisposeBag()
      super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    makeConstraint()
    bindInput()
    bindOutput()
  }

  func configureView() {
    view.backgroundColor = R.color.black()
    [titleLabel, subLabel ,characterButton, editLabel,talkButton, musicButton, shareButton].forEach {
      view.addSubview($0)
    }

    titleLabel.text = "Hi,"
    titleLabel.font = R.font.pressStart2PRegular(size: 30)
    titleLabel.textAlignment = .center
    titleLabel.textColor = R.color.whitegrey()

    subLabel.text = "stranger" // MARK: -
    subLabel.font = R.font.pressStart2PRegular(size: 20)
    subLabel.textAlignment = .center
    subLabel.textColor = R.color.whitegrey()

    characterButton.setImage(R.image.monkey_image(), for: .normal) // MARK: -
    characterButton.clipsToBounds = true
    characterButton.layer.borderWidth = 1
    characterButton.layer.borderColor = R.color.whitegrey()?.cgColor

    editLabel.text = "edit"
    editLabel.font = R.font.pressStart2PRegular(size: 16)
    titleLabel.numberOfLines = 0
    editLabel.textAlignment = .center
    editLabel.textColor = R.color.whitegrey()

    talkButton.setTitle("> Talk to Devs", for: .normal)
    talkButton.titleLabel?.font = R.font.pressStart2PRegular(size: 16)
    talkButton.setTitleColor(R.color.whitegrey(), for: .normal)
    talkButton.setTitleColor(R.color.green(), for: .selected)

    musicButton.setTitle("> Music Off", for: .normal) // MARK: -
    musicButton.titleLabel?.font = R.font.pressStart2PRegular(size: 16)
    musicButton.setTitleColor(R.color.whitegrey(), for: .normal)
    musicButton.setTitleColor(R.color.green(), for: .selected)

    shareButton.setTitle("> Share this app", for: .normal)
    shareButton.titleLabel?.font = R.font.pressStart2PRegular(size: 16)
    shareButton.setTitleColor(R.color.whitegrey(), for: .normal)
    shareButton.setTitleColor(R.color.green(), for: .selected)
  }

  func makeConstraint() {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height

    titleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.leading.greaterThanOrEqualToSuperview().offset(20)
      $0.trailing.lessThanOrEqualToSuperview().offset(-20)
      $0.top.equalToSuperview().offset(height * 0.21) // MARK: -
    }

    subLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.leading.greaterThanOrEqualToSuperview().offset(20)
      $0.trailing.lessThanOrEqualToSuperview().offset(-20)
      $0.top.equalTo(titleLabel.snp.bottom)
    }

    characterButton.snp.makeConstraints {
      $0.height.width.equalTo(width * 0.47)
      $0.top.equalTo(titleLabel.snp.bottom).offset(37)
      $0.centerX.equalToSuperview()
    }

    editLabel.snp.makeConstraints {
      $0.bottom.equalTo(characterButton.snp.bottom).offset(-15)
      $0.trailing.equalTo(characterButton.snp.trailing).offset(-13)
    }

    talkButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(musicButton.snp.top).offset(-8) // MARK: -
      $0.leading.greaterThanOrEqualToSuperview().offset(20)
      $0.trailing.lessThanOrEqualToSuperview().offset(-20)
    }

    musicButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(shareButton.snp.top).offset(-8)
      $0.leading.greaterThanOrEqualToSuperview().offset(20)
      $0.trailing.lessThanOrEqualToSuperview().offset(-20)
    }

    shareButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.lessThanOrEqualToSuperview().offset(-height * 0.16)
      $0.leading.greaterThanOrEqualToSuperview().offset(20)
      $0.trailing.lessThanOrEqualToSuperview().offset(-20)
    }
  }

  func bindInput() {
    let input = viewModel.input
    talkButton.rx.tap
      .bind(to: input.talkButtonTapped)
      .disposed(by: disposeBag)

    input.musicState
      .subscribe(onNext: {
        switch $0 {
        case .playing:
          print("playing")
          self.musicButton.rx.title().onNext("> Music Off")
        case .pause:
          print("pause")
          self.musicButton.rx.title().onNext("> Music On")
        case .error:
          print("error")
          self.musicButton.rx.title().onNext("> Music On")
        }
      })
      .disposed(by: disposeBag)
    

    shareButton.rx.tap
      .bind(to: input.shareButtonTapped)
      .disposed(by: disposeBag)
  }

  func bindOutput() {
    let output = viewModel.transform()
    output.pushDevView
      .drive(onNext: {
        print($0)
      })
      .disposed(by: disposeBag)

    output.actionSheetView
      .drive(onNext: {
        print($0)
      })
      .disposed(by: disposeBag)
  }

  
}
