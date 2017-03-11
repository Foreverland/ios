//
//  String+Extensions.swift
//  WWDCFamily
//
//  Created by Adrian Domanico on 3/10/17.
//  Copyright © 2017 WWDC Family. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
