//
//  ViewType.swift
//  TipCalculator
//
//  Created by Jamie Chen on 2021-05-10.
//

import Foundation

enum ViewType {
    case tipSlider
    case tipTextField
    
    enum SubViewTypes {
        case calculateTipButton
        case tipPercentageTextField
        case adjustTipPercentatgeSlider
    }
    
    var subViews: [SubViewTypes] {
        switch self {
        case .tipTextField:
            return [.calculateTipButton, .tipPercentageTextField]
        case .tipSlider:
            return [.adjustTipPercentatgeSlider]
        }
    }
}
