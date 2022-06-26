//
//  QuestionViewBuilder.swift
//  FindPersona
//
//  Created by JD_MacMini on 2022/06/26.
//

import UIKit

protocol QuestionViewBuilderType: ViewBuilderType {
    //var buttonTitle: String { get }
    //var nextView: QuestionViewBuilderType { get }
}


enum QuestionViewBuilder {
    case first
    case second
    case third    
}

extension QuestionViewBuilder: QuestionViewBuilderType {
    var view: UIViewController {
        switch self {
        case .first:
            let viewModel = MainViewModel()
            return MainViewController(viewModel: viewModel, nextView: .second)
        case .second:
            let viewModel = MainViewModel()
            return MainViewController(viewModel: viewModel, nextView: .third)
        case .third:
            let viewModel = MainViewModel()
            return MainViewController(viewModel: viewModel, nextView: .first)
        }
    }
}
