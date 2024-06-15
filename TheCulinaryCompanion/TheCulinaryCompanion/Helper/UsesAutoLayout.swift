//
//  UsesAutoLayout.swift
//  TheCulinaryCompanion
//
//  Created by Rodney Zhang on 2024-06-15.
//

import UIKit

@propertyWrapper
public struct UsesAutoLayout<T: UIView> {
  public var wrappedValue: T {
    didSet {
      wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
  }

  public init(wrappedValue: T) {
    self.wrappedValue = wrappedValue
    wrappedValue.translatesAutoresizingMaskIntoConstraints = false
  }
}
