//
//  ViewType.swift
//  FindPersona
//
//  Created by JD_MacMini on 2022/06/26.
//

import Foundation
import RxSwift

protocol ViewType: AnyObject {
    associatedtype ViewModel: ViewModelType
    
    var disposeBag: DisposeBag { get }
    var viewModel: ViewModel { get }
    
    // addSubView, color, text....
    func configureView()
    // AutoLayout (SnapKit)
    func makeConstraint()
    
    // Input Binding
    func bindInput()
    func bindOutput()
}

// ViewType : 뷰모델을 가지고 있음. 뷰모델이랑 바인딩함.
// ViewModelType: Input, Output. Input 뷰랑 바인딩. Output 뷰모델에서 transform output이 다시 뷰랑 바인딩.

/*
 
 view ---- viewmodel
            buttom tap -> input
            output -> view UI
 */
