//
//  ViewModelType.swift
//  FindPersona
//
//  Created by JD_MacMini on 2022/06/26.
//

import Foundation
import RxSwift

// Input, Output
protocol ViewModelType: AnyObject {
    // Input, Output은 구조체를 사용.
    associatedtype Input
    associatedtype Output
    
    // 얘는 초기화를 함, output은 안함
    var input: Input { get }
    
    var disposeBag: DisposeBag { get }
    
    func transform() -> Output
}
