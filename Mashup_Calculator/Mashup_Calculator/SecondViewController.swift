//
//  SecondViewController.swift
//  Mashup_Calculator
//
//  Created by 김현태 on 25/11/2018.
//  Copyright © 2018 onemoon. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var baseNumberLabel: UILabel!
    @IBOutlet weak var targetNumberLabel: UILabel!
    @IBOutlet var numberPadButton: [UIButton]!
    @IBOutlet weak var operatorButton: UIButton!
    
    var textToSet: String?
    var errorAlert = UIAlertController()
    var multiplyZeroAlert = UIAlertController()
    var multiplyZeroFlag: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        operatorButton.setTitle(textToSet, for: .normal)
        baseNumberLabel.text = SharedClass.shared.value == nil ? "0" : SharedClass.shared.value
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        errorAlert = makeAlert(mainTitle: "Nop", mainMessage: "number can't divided by 0" , "I Got It")
        multiplyZeroAlert = makeAlert(mainTitle: "Are You Sure?", mainMessage: "you try multiply number by zero", "OK" ,"My Mistake")
        
        // 현재는 [UIButton] 에 액션을 일일이 연결
        // button 자체에 액션을 주거나 , button에 클래스를 만들어서 액션을 담는 방식을 구상해보자
//        for (index, button) in numberPadNumberButton.enumerated() {
//            button.addTarget(self, action: #selector(numberPadButtonTab(_:)), for: .touchUpInside)
//            button.tag = index + 1
//        }
    }
    
//    @objc func numberPadButtonTab(_ sender: UIButton) {
//        print(sender.tag)
//    }

    @IBAction func touchUpPadButton(_ sender: UIButton) {
        guard let nowTargetLabel: String = targetNumberLabel.text , targetNumberLabel.text!.count <= 10 else { return }
        guard let padNumber: String = sender.titleLabel?.text else { return }
        
        if nowTargetLabel == "0" {
            targetNumberLabel.text = sender.titleLabel?.text
        } else {
            targetNumberLabel.text = targetNumberLabel.text! + padNumber
        }
    }
    
    @IBAction func touchUpOperatorButton(_ sender: UIButton) {
        var result: String = ""
        guard let baseNumber: String = baseNumberLabel.text else { return }
        guard let sourceNumber: String = targetNumberLabel.text else { return }
        guard let operatorString: String = sender.titleLabel?.text else { return }
        
        switch OperatorEnum.init(text: operatorString) {
        case .plus:
            result = calclateTwoStr(operator: .plus, base: baseNumber, source: sourceNumber)
        case .minus:
            result = calclateTwoStr(operator: .minus, base: baseNumber, source: sourceNumber)
        case .divide:
            result = calclateTwoStr(operator: .divide, base: baseNumber, source: sourceNumber)
        case .multiply:
            result = calclateTwoStr(operator: .multiply, base: baseNumber, source: sourceNumber)
        }
        baseNumberLabel.text = result
        SharedClass.shared.value = result
        targetNumberLabel.text = "0"
    }
    
    func calclateTwoStr(operator op: OperatorEnum ,base baseNumberStr: String, source sourceNumberStr: String) -> String {
        // 나누기가 계속 될경우 base 가 A.xxx의 String이 되는데 Int로 이 값을 바꾸려고 하는경우 아래 guard baseNumber에서 걸림
        // 그래서 여기서 해당경우의 로직을 만듦
        var newBaseStr: String = baseNumberStr
        if baseNumberStr.contains(".") {
            if sourceNumberStr != "0" && op == .divide {
                let base: Float = Float(baseNumberStr) ?? 0
                let source: Float = Float(sourceNumberStr) ?? 1
                return String(base/source)
            } else if op == .divide {
                return String(baseNumberStr.split(separator: ".")[0])
            } else {
                newBaseStr = String(baseNumberStr.split(separator: ".")[0])
            }
        }
        
        guard let baseNumber = Int(newBaseStr) else { return "" }
        guard let sourceNumber: Int = Int(sourceNumberStr) else { return "" }
        var result: String = ""
        switch op {
            case .plus:
                result = String(baseNumber + sourceNumber)
            case .minus:
                result = String(baseNumber - sourceNumber)
            case .divide:
                if sourceNumber == 0 {
                    present(errorAlert, animated: true, completion: nil)
                    result = String(baseNumber)
                    break
                }
                result = String(Float(baseNumber) / Float(sourceNumber))
            
            case .multiply:
                // 0 를 곱했을때 뭔가 액션을 넣으려고 했으나 실패함... 질문하기
//                if sourceNumber == 0 {
//                    present(multiplyZeroAlert, animated: true, completion: {
//                        // 띄워지는게 끝났을 때 실행된다. -> 다음으로 넘어가는게 아니다...
//                        // 심지어 out of completion 이 먼저 실행
//                        print("completion")
//                        print(self.multiplyZeroFlag)
//                    })
//                    print("out of completion")
//
//                    if self.multiplyZeroFlag == true {
//                        result = String(baseNumber * sourceNumber)
//                    } else {
//                        result = String(baseNumber)
//                    }
//                } else {
//                    result = String(baseNumber * sourceNumber)
//                }
            result = String(baseNumber * sourceNumber)
        }
        

        return result
    }
    
    // one button alert view
    func makeAlert(mainTitle tit: String , mainMessage mainMsg: String , _ buttonMessage: String...) -> UIAlertController {
        let resultAlert = UIAlertController(title: tit, message: mainMsg, preferredStyle: .alert)
        // preferredStyle -> .actionSheet: 아래에서 올라오는 alert
        if buttonMessage.count == 1 {
            let cancelAction = UIAlertAction(title: buttonMessage[0], style: UIAlertAction.Style.cancel, handler: nil)
            resultAlert.addAction(cancelAction)
        } else if buttonMessage.count == 2 {
            let okAction = UIAlertAction(title: buttonMessage[1], style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in self.multiplyZeroFlag = true })
            let cancelAction = UIAlertAction(title: buttonMessage[0], style: UIAlertAction.Style.cancel, handler: {(alert: UIAlertAction!) in self.multiplyZeroFlag = false })
            resultAlert.addAction(okAction)
            resultAlert.addAction(cancelAction)
        }
        
        return resultAlert
    }
}
