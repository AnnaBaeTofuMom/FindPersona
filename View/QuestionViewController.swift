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
import Rswift

class QuestionViewController: UIViewController, ViewType {
    typealias ViewModel = MainViewModel
    
    var disposeBag = DisposeBag()
    var nextViewBuilder: ViewBuilderType
    
    var questionLabel = UILabel()
    var imageView = UIImageView()
    var firstChoiceButton = UIButton()
    var secondChoiceButton = UIButton()
    let nextButton = UIButton()

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
        view.backgroundColor = R.color.black()
        configureView()
        makeConstraint()
        bindInput()
        bindOutput()
    }
    
    func configureView() {
        [questionLabel, imageView, firstChoiceButton, secondChoiceButton, nextButton].forEach {
            view.addSubview($0)
        }
        questionLabel.text = "Which word describes your personality the best ?"
        questionLabel.font = R.font.pressStart2PRegular(size: 20)
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        questionLabel.textColor = R.color.whitegrey()
        
        nextButton.backgroundColor = .clear
        nextButton.setTitle("> next", for: .normal)
        nextButton.titleLabel?.textColor = R.color.whitegrey()
        nextButton.titleLabel?.font = R.font.pressStart2PRegular(size: 17)
        
        imageView.image = R.image.woods_image()
        
        firstChoiceButton.setTitle("> Extrovert", for: .normal)
        firstChoiceButton.titleLabel?.font = R.font.pressStart2PRegular(size: 17)
        firstChoiceButton.setTitleColor(R.color.whitegrey(), for: .normal)
        firstChoiceButton.setTitleColor(R.color.green(), for: .selected)
        
        secondChoiceButton.setTitle("> Introvert", for: .normal)
        secondChoiceButton.titleLabel?.font = R.font.pressStart2PRegular(size: 17)
        secondChoiceButton.setTitleColor(R.color.whitegrey(), for: .normal)
        secondChoiceButton.setTitleColor(R.color.green(), for: .selected)
    }
    
    func makeConstraint() {
        questionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 100)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(43)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(questionLabel.snp.bottom).offset(45)
        }
        
        firstChoiceButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(45)
        }
        
        secondChoiceButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(firstChoiceButton.snp.bottom).offset(8)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(firstChoiceButton.snp.bottom).offset(120)
        }
        
    }
    
    func bindInput() {
        let input = viewModel.input
        nextButton.rx.tap
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
