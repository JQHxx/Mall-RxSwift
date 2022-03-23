//
//  ViewController.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(API.Home.banner)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let VC = LoginVC()
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
    }
}

