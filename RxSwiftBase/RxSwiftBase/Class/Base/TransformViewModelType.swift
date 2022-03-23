//
//  ViewModelType.swift
//  RxSwiftBase
//
//  Created by OFweek01 on 2022/3/23.
//

import Foundation

protocol TransformViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

/*
final class TransformViewModel: TransformViewModelType {
    
    struct Input {
        let message: Observable<String>
        let send: Observable<Void>
    }
    
    struct Output {
        let result: Driver<String>
    }
    
    func transform(input: TransformViewModel.Input) -> TransformViewModel.Output {
        let result = input.send
            .withLatestFrom(input.message)
            .map { (message) -> String in
                return "viewModel1: \(message)"
            }
            .startWith("result1")
            .asDriver(onErrorJustReturn: "")
        return Output.init(result: result)
    }
    
}
 */


/*
func bindModel1() {
    let input = TransformViewModel.Input.init(message: textField.rx.text.orEmpty.asObservable(),
                                              send: sendButton.rx.tap.asObservable())
    let output = viewModel1.transform(input: input)
    output.result
        .drive(label_1.rx.text)
        .disposed(by: rx.disposeBag)
}
 */
