//
//  OperatorEnum.swift
//  Mashup_Calculator
//
//  Created by 김현태 on 27/11/2018.
//  Copyright © 2018 onemoon. All rights reserved.
//

import Foundation

enum OperatorEnum: CaseIterable{
    // case + 같은 경우는 예약어라서 할당이 안된다.
    case plus , minus , divide , multiply

    var text:String{
        switch self{
            case .plus:
                return "+"
            case .minus:
                return "-"
            case .divide:
                return "/"
            case .multiply:
                return "*"
        }
    }
    
    init(text: String) {
        switch text {
        case "+":
            self = .plus
        case "-":
            self = .minus
        case "/":
            self = .divide
        case "*":
            self = .multiply
        default:
            // MARK: I want to make error
            self = .plus
        }
    }
    // Enum iteration => Use CaseIterable
    // MARK: Use static Or Error because Swift check toArray as member?
    static func toArray() -> Array<OperatorEnum> {
        var resultArray: [OperatorEnum] = []
        for element in OperatorEnum.allCases {
            resultArray.append(element)
        }
        return resultArray
    }
}
