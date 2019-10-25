//
//  Target_Home.swift
//  Mall
//
//  Created by HJQ on 2019/10/26.
//  Copyright © 2019 JQHxx. All rights reserved.
//

import UIKit

class Target_HomeModule: NSObject {
    @objc func Action_HomeViewContoller(_ params: [AnyHashable: Any]) -> UIViewController {
        let vc = HomeViewController()
        vc.view.backgroundColor = UIColor.orange
        return vc;
    }
}
