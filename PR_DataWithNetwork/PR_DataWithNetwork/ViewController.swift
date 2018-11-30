//
//  ViewController.swift
//  PR_DataWithNetwork
//
//  Created by Hyeontae on 29/11/2018.
//  Copyright © 2018 onemoon. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher


class ViewController: UIViewController {

    @IBOutlet weak var myIMGView: UIImageView!
    @IBOutlet weak var myLabelOne: UILabel!
    @IBOutlet weak var myLabelTwo: UILabel!
    @IBOutlet weak var myTextView: UITextView!
    
    let baseURL = "http://ec2-13-209-245-253.ap-northeast-2.compute.amazonaws.com:8080"
    let additionalURL = "/info/alliance"
    let jsonDecoder: JSONDecoder = JSONDecoder()
    
//    var imageURL: URL
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        

        
        }
    
    @IBAction func touchSendBtn(_ sender: UIButton) {
        var jsonData: AllianceCard = AllianceCard.init()
        Alamofire.request(
            baseURL + additionalURL,
            method: .get,
            parameters: [:], // nil이 아니라 [:]?
            encoding: URLEncoding.default,
            headers: ["Content-Type":"application/json", "Accept":"application/json"]
            )
            .validate(statusCode: 200..<300)
            .responseJSON {
                response in
                guard let data = response.data else { return }
//                let utf8Text = String(data: data, encoding: .utf8) ?? String(decoding: data, as: UTF8.self)
                
                if let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)")
                }
                
                do {
                    jsonData = try self.jsonDecoder.decode(AllianceCard.self, from: data)
                    print(jsonData)
                } catch {
                    print("error: ", error.localizedDescription)
                }
                
                // king fisher
                //                self.myIMGView.kf.setImage(with: URL(string: jsonData.imageURL))
                //                self.myIMGView.image = UIImage(named: jsonData.imageURL)
                
                //                response in
                //                if let JSON = response.result.value {
                //                    print(JSON)
                //            }
                
                DispatchQueue.global().async {
                    guard let imageURL: URL = URL(string: jsonData.imageURL) else { return }
                    guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
                    // try? 사용
                    DispatchQueue.main.async {
                        self.myIMGView.image = UIImage(data: imageData)
                    }
                }
                
                self.myLabelOne.text = jsonData.name
                self.myLabelTwo.text = jsonData.kind
                self.myTextView.text = jsonData.locatiionStr
            }
        
        
        
    }
    
    
    
}
