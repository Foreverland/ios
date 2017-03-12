//
//  API.swift
//  WWDCFamily
//
//  Created by Adrian Domanico on 3/11/17.
//  Copyright © 2017 WWDC Family. All rights reserved.
//

import Foundation
import MapKit

final class API {

    typealias UserCompletion = (Bool,[User]) -> Void
    
    class func getNearbyUsers(completion: UserCompletion) {
        let testUser = User(id: "test", name: "Adrian", bio: "Motorcycles", coordinate: CLLocationCoordinate2DMake(37.7833, -122.4167), imageURL: nil)
        completion(true,[testUser])
    }
}
