//
//  ViewController.swift
//  Mall
//
//  Created by midland on 2019/10/23.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard let VC = CTMediator.sharedInstance()?.Home_Module_homeViewController(callback: { (result) in

        }) else { return }

        // let homeVC = CollectionViewTest1VC()
        self.present(VC, animated: true, completion: nil)
    }

}

