//
//  Weakify.swift
//  TestFilters
//
//  Created by Andrew Vasiliev on 21.03.2020.
//  Copyright © 2020 Deepkotix. All rights reserved.
//

func weakify <T: AnyObject, U>(owner: T, function: @escaping ReturningAction<T, Action<U>>) -> Action<U> {
    return { [weak owner] obj in
        if let this = owner {
            function(this)(obj)
        }
    }
}

func weakify <T: AnyObject>(owner: T, function: @escaping ReturningAction<T, VoidAction>) -> VoidAction {
    return { [weak owner] in
        if let this = owner {
            function(this)()
        }
    }
}

func weakify <T: AnyObject, U>(owner: T, function: @escaping ReturningAction<T, VoidActionThatReturns<U>>) -> VoidActionThatReturns<U?> {
    return { [weak owner] in
        return owner.map(function)?()
    }
}

func weakify <T: AnyObject, U, V>(owner: T, function: @escaping ReturningAction<T, ReturningAction<U, V>>) -> ReturningAction<U, V?> {
    return { [weak owner] obj in
        return owner.map(function)?(obj)
    }
}
