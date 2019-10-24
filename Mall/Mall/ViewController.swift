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
        let homeVC = CollectionViewTest1VC()
        self.present(homeVC, animated: true, completion: nil)
    }

}

