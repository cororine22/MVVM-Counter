//
//  ViewController.swift
//  MVVMCounter
//
//  Created by 北本杏菜 on 2020/03/15.
//  Copyright © 2020 北本杏菜. All rights reserved.
//

import RxSwift
import RxCocoa

final class CounterViewController: UIViewController {
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = CounterViewModel(
            countUp: plusButton.rx.controlEvent(.touchUpInside).asObservable(),
            countDown: minusButton.rx.controlEvent(.touchUpInside).asObservable(),
            bag: bag
        )
        
        viewModel.countLabelColor
            .bind(to: counterLabel.rx.backgroundColor)
            .disposed(by: bag)
        
        viewModel.countLabelValue
            .bind(to: counterLabel.rx.text)
            .disposed(by: bag)
        
        viewModel.countError
            .subscribe(onNext: {
                self.showErrorAlert()
            })
            .disposed(by: bag)
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: nil, message: "マイナスの値を入力することはできません", preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }


}

