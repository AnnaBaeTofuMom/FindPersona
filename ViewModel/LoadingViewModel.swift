//
//  LoadingViewModel.swift
//  FindPersona
//
//  Created by JD_MacMini on 2022/07/07.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

final class LoadingViewModel: ViewModelType {
    struct Input {
        let loadingDidEnd = PublishRelay<Void>()
    }
    
    struct Output {
        let pushResultView: Driver<Void>
    }
    
    var input = Input()
    var disposeBag = DisposeBag()
    
    func transform() -> Output {
        let pushResultView = input.loadingDidEnd            
            .asDriver(onErrorJustReturn: Void())
        
        return Output(pushResultView: pushResultView)
    }
}
