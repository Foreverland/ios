//
//  StoryboardInstance.swift
//  WWDCFamily
//
//  Created by Adrian Domanico on 3/10/17.
//  Copyright © 2017 WWDC Family. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardInstance: class {
    static var storyboardName: String { get }
    static var identifier: String { get }
}

extension StoryboardInstance {

    static var identifier: String {
        return String(describing: Self.self)
    }

    static func storyboardInit() -> Self {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier) as! Self
    }
}
