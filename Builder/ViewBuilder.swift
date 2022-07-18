//
//  ViewBuilder.swift
//  FindPersona
//
//  Created by JD_MacMini on 2022/07/06.
//

import UIKit

enum ViewBuilder {
    case start
    //case loading
    //case setting
}

extension ViewBuilder: ViewBuilderType {
    var view: UIViewController {
        switch self {
        case .start:
            let viewModel = StartViewModel()
            let view = StartViewController(viewModel: viewModel)
            return view
        }
    }
}
