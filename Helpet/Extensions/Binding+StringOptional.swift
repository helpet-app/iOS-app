//
//  Binding+StringOptional.swift
//  Helpet
//
//  Created by Efim Nikitin on 13.02.2023.
//

import SwiftUI

extension Binding where Value == String {
    init(_ source: Binding<Value?>, defaultValue: Value = "") {
        self.init(
            get: {
                source.wrappedValue ?? defaultValue
            },
            set: { newValue in
                if newValue == defaultValue {
                    source.wrappedValue = nil
                } else {
                    source.wrappedValue = newValue
                }
            })
    }
}
