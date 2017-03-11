//
//  MapDatasource.swift
//  WWDCFamily
//
//  Created by Adrian Domanico on 3/10/17.
//  Copyright © 2017 WWDC Family. All rights reserved.
//

import Foundation
import MapKit

protocol MapDataObserver: class {
    func didChange(location: CLLocation)
}

final class MapDataSource: NSObject {

    fileprivate let locationManager: CLLocationManager = CLLocationManager()

    fileprivate(set) var currentLocation: CLLocation?

    weak var observer: MapDataObserver?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = kCLDistanceFilterNone
    }

    // MARK: Map Regions

    var sfRegion: MKCoordinateRegion {
        return MKCoordinateRegion(center: CLLocationCoordinate2DMake(37.7833, -122.4167), span: MKCoordinateSpanMake(0.1, 0.1))
    }

    var currentRegion: MKCoordinateRegion? {
        guard let currentLocation = currentLocation else { return nil }
        return MKCoordinateRegionMake(currentLocation.coordinate, MKCoordinateSpanMake(0.01, 0.01))
    }

    func zoomed(coordinate: CLLocationCoordinate2D, span: MKCoordinateSpan = MKCoordinateSpanMake(0.0025, 0.0025)) -> MKCoordinateRegion {
        return MKCoordinateRegionMake(coordinate, span)
    }

    // MARK: Permissions & State

    var isAuthorized: Bool {
        let status = CLLocationManager.authorizationStatus()
        return status != CLAuthorizationStatus.denied && status != CLAuthorizationStatus.restricted
    }

    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

}

extension MapDataSource: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status != CLAuthorizationStatus.denied && status != CLAuthorizationStatus.restricted else { return }
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let newLocation = locations.first, newLocation.horizontalAccuracy < 15.0, newLocation.horizontalAccuracy > 0.0 else { return }
        currentLocation = newLocation
        observer?.didChange(location: newLocation)
    }

}
