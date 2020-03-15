//
//  CounterViewModel.swift
//  MVVMCounter
//
//  Created by 北本杏菜 on 2020/03/15.
//  Copyright © 2020 北本杏菜. All rights reserved.
//

import RxSwift

final class CounterViewModel {
    
    let countLabelValue: Observable<String>
    let countLabelColor: Observable<UIColor>
    let countError: Observable<Void>
    
    private let model = CounterModel()
    
    init(countUp: Observable<Void>,
         countDown: Observable<Void>,
         bag: DisposeBag) {
        
        let model = CounterModel()
        
        countUp
            .subscribe(onNext: {
                model.countUp()
            })
            .disposed(by: bag)
        
        countDown
            .subscribe(onNext: {
                model.countDown()
            })
            .disposed(by: bag)
        
        countLabelColor = model.countNumber
            .map { num -> UIColor in
                if num == 0 {
                    return .red
                } else {
                    return .clear
                }
            }
        
        countLabelValue = model.countNumber
            .map { $0.description }
        
        countError = model.countError
    }
}
