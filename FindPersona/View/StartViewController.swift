//
//  StartViewController.swift
//  FindPersona
//
//  Created by 경원이 on 2022/06/28.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxRelay
import SnapKit
import Rswift

class StartViewController: UIViewController, ViewType {
    typealias ViewModel = StartViewModel
    var disposeBag: DisposeBag
    var viewModel: ViewModel
    
    var logoImageView = UIImageView()
    var orbitImageView = UIImageView()
    var startButton = UIButton()
    var settingsButton = UIButton()

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
        [logoImageView, orbitImageView, startButton, settingsButton].forEach {
            view.addSubview($0)
        }
        
        view.backgroundColor = R.color.black()
        logoImageView.image = R.image.text_logo()
        orbitImageView.image = R.image.orbit_image()
        startButton.setTitle("> start new", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "PressStart2P-Regular", size: 20)
        startButton.backgroundColor = .clear
        settingsButton.setTitle("> settings", for: .normal)
        settingsButton.titleLabel?.font = UIFont(name: "PressStart2P-Regular", size: 20)
        settingsButton.backgroundColor = .clear

    }
    
    func makeConstraint() {
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height/5 as ConstraintOffsetTarget)
        }
        
        orbitImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(40)
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(orbitImageView.snp.bottom).offset(UIScreen.main.bounds.height/7 as ConstraintOffsetTarget)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(startButton.snp.bottom).offset(8)
        }
    }
    
    func bindInput() {
        let input = viewModel.input
        
        startButton.rx.tap
            .bind(to: input.startButtonDidTap)
            .disposed(by: disposeBag)
    }
    
    func bindOutput() {
        let output = viewModel.transform()
        
        output.startButtonDidTap            
            .drive(self.rx.pushFirstQuestionView)
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base: StartViewController {
    var pushFirstQuestionView: Binder<Void> {
        return Binder(base.self) { vc, _ in
            let view = QuestionViewBuilder.first.view
            vc.navigationController?.pushViewController(view, animated: true)
        }
    }
    
//    var pushSettingView: Binder<Void> {
//        return Binder(base.self) {
//            // setting view push
//        }
//    }
}
