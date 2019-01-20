//
//  ViewController.swift
//  PR_semiModall
//
//  Created by Hyeontae on 14/01/2019.
//  Copyright © 2019 onemoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var transitionDelegate = PresentationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        transitionDelegate.direction = .bottom
    }

    
    @IBAction func btnShow(_ sender: Any) {
        // MARK: - 첫번째 버전
        // 문제점: X에서 백그라운드와 띄우는 뷰와 색상이 다르다는점 , 전체를 모달로 감싼다는 점 ? 근데 이거는 원래 그런건지 잘 모르겠음
        // 사용하기는 간단하지만 활용하기는 약간 아쉬움
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let pvc = storyboard.instantiateViewController(withIdentifier: "SubViewController") as! SubViewController
//        pvc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        self.present(pvc, animated: true, completion: nil)
        // MARK: - 두번째 버전
        // raywendrich 참고하자 !
    
//        if let bottomModal = storyboard!.instantiateViewControllerWithIdentifier("EXStoryBoardID") as? ResultViewController {
//            presentViewController(resultController, animated: true, completion: nil)
//        }
        
        let modalStroyboard: UIStoryboard = UIStoryboard(name: "Modal", bundle: nil)
        guard let bottomModal: UIViewController = modalStroyboard.instantiateViewController(withIdentifier: "BottomModal") else {
            return
        }
        bottomModal.transitioningDelegate = transitionDelegate
        bottomModal.modalPresentationStyle = .custom
        
        present(bottomModal, animated: true)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let controller = segue.destination as? ModalClass {
//
//        }
    }
    
    
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
}

//class SubViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("hello subView")
//    }
//
//    @IBAction func hideSubView(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//}
//
