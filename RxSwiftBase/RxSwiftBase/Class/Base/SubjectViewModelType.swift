//
//  SubjectViewModelType.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/23.
//

import Foundation

protocol SubjectViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input {get}
    var output: Output {get}
}

/* 内部初始化Input
final class SubjectViewModel: SubjectViewModelType {
    
    var input: SubjectViewModel.Input
    var output: SubjectViewModel.Output
    
    struct Input {
        let message: AnyObserver<String>
        let send: AnyObserver<Void>
    }
    
    struct Output {
        let result: Driver<String>
    }
    
    private let messageSubject = PublishSubject<String>()
    private let sendSubject = PublishSubject<Void>()
    
    init() {
        
        let result = sendSubject
            .withLatestFrom(messageSubject)
            .map { (message) -> String in
                return "viewModel2: \(message)"
            }
            .startWith("result2")
            .asDriver(onErrorJustReturn: "")
        input = Input.init(message: messageSubject.asObserver(), send: sendSubject.asObserver())
        output = Output.init(result: result)
    }
    
}
 */

/*
func bindModel2() {
    textField.rx.text.orEmpty
        .subscribe(viewModel2.input.message)
        .disposed(by: rx.disposeBag)
    sendButton.rx.tap
        .subscribe(viewModel2.input.send)
        .disposed(by: rx.disposeBag)
    viewModel2.output.result
        .drive(label_2.rx.text)
        .disposed(by: rx.disposeBag)
}
 */
