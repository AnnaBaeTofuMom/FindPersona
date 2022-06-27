//
//  QuestionViewBuilder.swift
//  FindPersona
//
//  Created by JD_MacMini on 2022/06/26.
//

import UIKit

protocol QuestionViewBuilderType: ViewBuilderType {
    // var buttonTitle: String { get }
    var nextViewBuilder: QuestionViewBuilderType { get }
}

enum QuestionViewBuilder {
    case first
    case second
    case third    
}

extension QuestionViewBuilder: QuestionViewBuilderType {
    var view: UIViewController {
        let viewModel = MainViewModel()
        return MainViewController(viewModel: viewModel, nextView: nextViewBuilder)
    }
    
    var nextViewBuilder: QuestionViewBuilderType {
        switch self {
        case .first:
            return QuestionViewBuilder.second
        case .second:
            return QuestionViewBuilder.third
        case .third:
            // 마지막뷰는 다른뷰의 뷰빌더를 가져와야함
            return QuestionViewBuilder.first
        }
    }
}
