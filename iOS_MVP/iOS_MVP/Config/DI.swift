//
//  DI.swift
//  iOS_MVP
//
//  Created by Anna Ershova on 27.05.2024.
//

import Foundation
import SwiftUI

@propertyWrapper
struct Injected<T: AnyObject> {
    private var service: T?
    private weak var serviceManager = ServiceLocator.shared
    
    var wrappedValue: T? {
        mutating get {
            if service == nil {
                service = serviceManager?.getServices(type: T.self)
            }
            return service
        }
        mutating set {
            service = newValue
        }
    }

    public var projectedValue: Injected<T> {
        get { return self }
        set { self = newValue }
    }
}

@propertyWrapper
struct Default<T>: DynamicProperty {
    private var defaults: Defaults
    private let keyPath: ReferenceWritableKeyPath<Defaults, T>
    public init(_ keyPath: ReferenceWritableKeyPath<Defaults, T>, defaults: Defaults = .shared) {
        self.keyPath = keyPath
        self.defaults = defaults
    }

    public var wrappedValue: T {
        get { defaults[keyPath: keyPath] }
        nonmutating set { defaults[keyPath: keyPath] = newValue }
    }

    public var projectedValue: Binding<T> {
        Binding(get:
                    { defaults[keyPath: keyPath] },
                set:
                    { value in defaults[keyPath: keyPath] = value }
                )
    }
}
