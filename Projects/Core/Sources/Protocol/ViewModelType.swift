//
//  ViewModelType.swift
//  Core
//
//  Created by 류희재 on 2023/10/24.
//  Copyright © 2023 hellohidi. All rights reserved.
//

import Foundation

import RxSwift

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(from input: Input, disposeBag: DisposeBag) -> Output
}
