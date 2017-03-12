//
//  User.swift
//  WWDCFamily
//
//  Created by Adrian Domanico on 3/11/17.
//  Copyright © 2017 WWDC Family. All rights reserved.
//

import Foundation
import MapKit

final class User: NSObject {
    let id: String

    var name: String
    var bio: String?
    var imageURL: URL?

    var coordinate: CLLocationCoordinate2D

    init(id: String, name: String, bio: String? = nil, coordinate: CLLocationCoordinate2D, imageURL: URL? = nil) {
        self.id = id
        self.name = name
        self.bio = bio
        self.coordinate = coordinate
        self.imageURL = imageURL
        super.init()
    }
}

extension User {
    override var hashValue: Int {
        return id.hashValue
    }

    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}

extension User: MKAnnotation {

    var title: String? {
        return name
    }

    var subtitle: String? {
        return bio
    }
}
