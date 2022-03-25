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
    
    let provider = MoyaProvider<APIService>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(HTTPAPI.Home.banner)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
        let VC = LoginVC()
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
         */

        NetworkTools.request(with: APIService.testGet)
            .asObservable()
            .mapObject(type: SWeatherinfoModel.self)
            .subscribe { response in
                //debugPrint(response.mapString() ?? "")
                //debugPrint(String.init(data: response.data, encoding: String.Encoding.utf8) ?? "")
            } onError: { error in
                debugPrint(error.localizedDescription)
            }.disposed(by: rx.disposeBag)


 
        
//        provider.rx.request(.testGet)
//            //.filterSuccessfulStatusCodes()
//            .asObservable()
////            .mapJSON()
////            .asObservable()
//            //.mapJSONMappable(HttpBin.self)
//            //.observeOn(SerialDispatchQueueScheduler(internalSerialQueueName: "test"))
//            //.showHUD()
//            .subscribe { (event) in
//                switch event {
//                case let .next(httpBin):
//                    print("\n\n--------------- 网络示例RxSwift -------------------")
//                    debugPrint(httpBin)
//                    debugPrint(String.init(data: httpBin.data, encoding: String.Encoding.utf8))
//                    //print(httpBin.mapString() ?? "请求完毕")
//                case let .error(error):
//                    print(error.localizedDescription)
//                default:
//                    print(event)
//                }
//            }.disposed(by: rx.disposeBag)


            
            
    }
}

