//
//  MainViewModel.swift
//  FindPersona
//
//  Created by JD_MacMini on 2022/06/26.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

final class MainViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    
    struct Input {
        var testButtonDidTap = PublishRelay<Void>()
    }
    
    struct Output {
        var printedText: Driver<String>
    }
    
    var input = Input()
    
    func transform() -> Output {
        
        let printedText = input.testButtonDidTap
            .map { "프린트됨" }
            .asDriver(onErrorJustReturn: "")
        
        return Output(printedText: printedText)
    }
}
