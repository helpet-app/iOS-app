//
//  Optional+Operators.swift
//  Helpet
//
//  Created by Efim Nikitin on 03.02.2023.
//

import Foundation

func + <T: Numeric>(lhs: T?, rhs: T) -> T? {
    if let lhs = lhs {
        return lhs + rhs
    }

    return nil
}

func - <T: Numeric>(lhs: T?, rhs: T) -> T? {
    if let lhs = lhs {
        return lhs - rhs
    }

    return nil
}

func * <T: Numeric>(lhs: T?, rhs: T) -> T? {
    if let lhs = lhs {
        return lhs * rhs
    }

    return nil
}
