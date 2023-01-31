//
//  Publisher.swift
//  WeatherApp
//
//  Created by Juan camilo Navarro on 30/01/23.
//
import Combine

public extension Publisher where Self.Failure == Never {

    func assignNoRetain<Root>(
        to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
        on object: Root
    ) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
