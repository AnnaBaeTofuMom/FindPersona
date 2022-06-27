//
//  MainViewController.swift
//  FindPersona
//
//  Created by JD_MacMini on 2022/06/26.
//

import UIKit
import RxSwift
import SnapKit
import RxCocoa
import RxRelay

class MainViewController: UIViewController, ViewType {
    typealias ViewModel = MainViewModel
    
    var disposeBag = DisposeBag()
    var nextViewBuilder: ViewBuilderType
    
    let testButton = UIButton()
    var viewModel: MainViewModel
    
    init(
        viewModel: ViewModel,
        nextView: ViewBuilderType
    ) {
        self.viewModel = viewModel
        self.nextViewBuilder = nextView
        super.init(nibName: nil, bundle: nil)        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        configureView()
        makeConstraint()
        bindInput()
        bindOutput()
    }
    
    func configureView() {
        view.addSubview(testButton)
        testButton.backgroundColor = .red
    }
    
    func makeConstraint() {
        testButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
    
    func bindInput() {
        let input = viewModel.input
        testButton.rx.tap
            .bind(to: input.testButtonDidTap)
            .disposed(by: disposeBag)
    }
    
    func bindOutput() {
        let output = viewModel.transform()        
        output.printedText
            .drive { [weak self] in
                guard let self = self else { return }                
                self.navigationController?.pushViewController(self.nextViewBuilder.view, animated: true)
            }.disposed(by: disposeBag)
    }
}
