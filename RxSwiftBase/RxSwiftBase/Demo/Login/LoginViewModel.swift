//
//  LoginViewModel.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/23.
//

import Foundation
import RxSwift
import RxCocoa

/**
 1、当account 没有输入内容时， password 、code 、codButton、loginButton 都不能点击
 2、当account 没有输入内容长度为11时，并且是手机号码, 可以输入password、code 、codButton
 3、当account、password、code 内容都满足时，loginButton可以点击
 */

class LoginViewModel: TransformViewModelType {
    
    typealias PInput = Input
    typealias POutput = Output

    struct Input {
        //输出流
        let account: Driver<String>
        let password: Driver<String>
        let loginTap: Driver<Void>
    }
    
    struct Output {
        let usernameUsable: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let usernameUsable = input.account.flatMapLatest { account in
            return LoginViewModel.accountValid(account: account)
        }
        
        /* share(replay:1) 防止重复订阅
        let usernameable: Observable<Bool> = input.account.asObservable().flatMapLatest({ (account) in
            return LoginViewModel.testAccountValid(account: account)
        }).share(replay:1)
         */

        
        let output = LoginViewModel.Output(usernameUsable: usernameUsable)
        return output
    }
    
    
    static func accountValid(account: String) -> Driver<Bool> {
        var result = false
        if account.count < 6 {
            
        } else {
            result = true
        }
        return Observable.just(result).asDriver(onErrorJustReturn: false)
    }
    
    static func testAccountValid(account: String) -> Observable<Bool> {
        var result = false
        if account.count < 6 {
            
        } else {
            result = true
        }
        return Observable.just(result)
    }
    
}
