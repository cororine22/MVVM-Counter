//
//  CounterModel.swift
//  MVVMCounter
//
//  Created by 北本杏菜 on 2020/03/15.
//  Copyright © 2020 北本杏菜. All rights reserved.
//

import RxSwift
import RxRelay

final class CounterModel {
    
    private(set) lazy var countNumber = _countNumber.asObservable()
    private let _countNumber = BehaviorRelay<Int>(value: 0)
    
    private(set) lazy var countError = _countError.asObservable()
    private let _countError = PublishSubject<Void>()
    
    func countUp() {
        let nextNum = _countNumber.value + 1
        _countNumber.accept(nextNum)
    }
    
    func countDown() {
        let nextNum = _countNumber.value - 1
        guard nextNum >= 0 else {
            _countError.onNext(())
            return
        }
        
        _countNumber.accept(nextNum)
    }
}
