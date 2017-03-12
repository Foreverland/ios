//
//  Identifiable.swift
//  WWDCFamily
//
//  Created by Adrian Domanico on 3/11/17.
//  Copyright © 2017 WWDC Family. All rights reserved.
//

import Foundation

protocol Identifiable: class {
}

extension Identifiable  {
    static var identifier: String {
        return String(describing: Self.self)
    }
}
