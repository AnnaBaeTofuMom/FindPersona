//
//  LoadingViewController.swift
//  FindPersona
//
//  Created by JD_MacMini on 2022/07/07.
//

import UIKit
import Lottie
import RxSwift

final class LoadingViewController: UIViewController, ViewType {
    typealias ViewModel = LoadingViewModel
    
    private let loadingLabel = UILabel()
    private let animationView = AnimationView(name: "LoadingBar")
    private let loadingImageView = UIImageView()
    
    var disposeBag = DisposeBag()
    var viewModel: LoadingViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
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
        [loadingLabel, animationView, loadingImageView].forEach { view.addSubview($0) }
        view.backgroundColor = R.color.black()
        loadingLabel.text = "Universe's\ncalling"
        loadingLabel.numberOfLines = 0
        loadingLabel.textAlignment = .center
        loadingLabel.font = UIFont(name: "PressStart2P-Regular", size: 20)
        animationView.play(fromProgress: 0.0, toProgress: 1.0, loopMode: .loop) { print($0) }
        animationView.backgroundColor = .clear
        loadingImageView.image = R.image.orbit_image()
    }
    
    func makeConstraint() {
        loadingImageView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.loadingImageViewInset)
            make.height.equalTo(loadingImageView.snp.width).multipliedBy(Constants.loadingImageViewRatio)
        }
        
        animationView.snp.makeConstraints { make in
            make.centerX.equalTo(loadingImageView)
            make.bottom.equalTo(loadingImageView.snp.top).offset(Constants.animationViewBottomOffset)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(Constants.animationViewHeight)
        }
        
        loadingLabel.snp.makeConstraints { make in
            make.centerX.equalTo(loadingImageView)
            make.bottom.equalTo(animationView.snp.top).offset(Constants.loadingLabelBottomOffset)
        }
    }
    
    func bindInput() {
        let input = viewModel.input
        Observable.just(Void())
            .delay(.seconds(3), scheduler: MainScheduler.instance)
            .bind(to: input.loadingDidEnd)
            .disposed(by: disposeBag)
    }
    
    func bindOutput() {
        let output = viewModel.transform()
        
        output.pushResultView
            .drive(self.rx.pushResultView)
            .disposed(by: disposeBag)
    }
    
    func stopAnimation() {
        animationView.stop()
    }
}

extension Reactive where Base: LoadingViewController {
    var pushResultView: Binder<Void> {
        return Binder(base.self) { vc, _ in
//            let view = ViewBuilder.result.view
//            vc.navigationController?.pushViewController(view, animated: true)
            vc.stopAnimation()
            print("Result View push")
        }
    }
}

extension LoadingViewController {
    enum Constants {
        static let loadingImageViewInset = 95
        static let loadingImageViewRatio = 85.0/200.0
        static let animationViewBottomOffset = -38
        static let animationViewHeight = 100
        static let loadingLabelBottomOffset = -8
    }
}
