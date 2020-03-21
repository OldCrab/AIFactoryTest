//
//  Actions.swift
//  TestFilters
//
//  Created by Andrew Vasiliev on 21.03.2020.
//  Copyright © 2020 Deepkotix. All rights reserved.
//

typealias VoidAction = () -> Void
typealias Action<T> = (T) -> Void
typealias VoidActionThatReturns<R> = () -> R
typealias ReturningAction<T, R> = (T) -> R
