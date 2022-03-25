//
//  ViewController.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/23.
//

import UIKit
import RxSwift
import Moya

class ViewController: UIViewController {
    
    private let provider = MoyaProvider<APIService>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(HTTPAPI.Home.banner)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
        let VC = LoginVC()
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
         */

        /*
        NetworkTools.request(with: APIService.testGet)
            .asObservable()
            .mapObject(type: SWeatherinfoModel.self)
            .subscribe { response in
                //debugPrint(response.mapString() ?? "")
                //debugPrint(String.init(data: response.data, encoding: String.Encoding.utf8) ?? "")
            } onError: { error in
                debugPrint(error.localizedDescription)
            }.disposed(by: rx.disposeBag)
         */


        APIService.testGet.request()
            .mapObject(type: SWeatherinfoModel.self)
            .subscribe { response in
                //debugPrint(response.mapString() ?? "")
                //debugPrint(String.init(data: response.data, encoding: String.Encoding.utf8) ?? "")
            } onError: { error in
                debugPrint(error.localizedDescription)
            }.disposed(by: rx.disposeBag)
        
        
    }
}

