//
//  StartViewModel.swift
//  FindPersona
//
//  Created by 경원이 on 2022/06/28.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

final class StartViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    
    struct Input {
        let startButtonDidTap = PublishRelay<Void>()
    }
    
    struct Output {
        let startButtonDidTap: Driver<Void>
    }
    
    var input = Input()
    
    func transform() -> Output {
        let startButtonDidTap = input.startButtonDidTap.asDriver(onErrorJustReturn: Void())
        return Output(startButtonDidTap: startButtonDidTap)
    }
}
