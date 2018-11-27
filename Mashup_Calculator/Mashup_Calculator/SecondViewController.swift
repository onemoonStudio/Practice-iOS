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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        operatorButton.setTitle(textToSet, for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for (index, button) in numberPadNumberButton.enumerated() {
//            button.addTarget(self, action: #selector(numberPadButtonTab(_:)), for: .touchUpInside)
//            button.tag = index + 1
//        }
    }
    
//    @objc func numberPadButtonTab(_ sender: UIButton) {
//        print(sender.tag)
//    }

    @IBAction func touchUpPadButton(_ sender: UIButton) {
//        print(sender.titleLabel?.text)
        guard let nowTargetLabel: String = targetNumberLabel.text , targetNumberLabel.text!.count <= 10 else { return }
        guard let padNumber: String = sender.titleLabel?.text! else { return }
        
        if nowTargetLabel == "0" {
            targetNumberLabel.text = sender.titleLabel?.text
        } else {
            targetNumberLabel.text = targetNumberLabel.text! + padNumber
        }
        
//        var hello: String = "world"
        
        
    }
    
    @IBAction func touchUpOperatorButton(_ sender: UIButton) {
        var result: String = ""
        guard let baseNumber: String = baseNumberLabel.text else { return }
        guard let sourceNumber: String = targetNumberLabel.text else { return }
        switch sender.titleLabel?.text {
        case "+":
            result = calclateTwoStr(operator: "+", base: baseNumber, source: sourceNumber)
        case "-":
            result = calclateTwoStr(operator: "-", base: baseNumber, source: sourceNumber)
        case "/":
            result = calclateTwoStr(operator: "/", base: baseNumber, source: sourceNumber)
        case "x":
            result = calclateTwoStr(operator: "*", base: baseNumber, source: sourceNumber)
        default:
            print("can not recognize")
        }
        baseNumberLabel.text = result
        targetNumberLabel.text = "0"
    }
    
    // 일단 인트로 생각?
    func calclateTwoStr(operator op: String ,base baseNumberStr: String, source sourceNumberStr: String) -> String {
        guard let baseNumber: Int = Int(baseNumberStr) else { return "" }
        guard let sourceNumber: Int = Int(sourceNumberStr) else { return "" }
        var result: String = ""
        switch op {
            case "+":
                result = String(baseNumber + sourceNumber)
            case "-":
                result = String(baseNumber - sourceNumber)
            case "/":
                result = String(baseNumber / sourceNumber)
            case "x":
                result = String(baseNumber * sourceNumber)
            default:
                print("can not recognize")
        }
        return result
    }
    
}
