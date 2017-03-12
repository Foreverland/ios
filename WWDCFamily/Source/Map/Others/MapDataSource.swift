import Foundation
import MapKit

protocol MapDataObserver: class {

    weak var mapView: MKMapView! { get }

    func didChange(location: CLLocation)
}

final class MapDataSource: NSObject {

    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    fileprivate(set) var currentLocation: CLLocation?

    weak var observer: MapDataObserver?

    private(set) var users: [User] = [] {
        didSet {
            reloadAnnotations()
        }
    }

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = kCLDistanceFilterNone

        NotificationCenter.default.addObserver(self, selector: #selector(MapDataSource.notificationAppResignActive), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapDataSource.notificationAppBecomingActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }

    // MARK: Data

    func refresh() {
        API.getNearbyUsers { [weak self] (success, users) in
            guard success else {
                return
            }
            self?.users = users
        }
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

    // MARK: Annotations

    private func reloadAnnotations() {
        observer?.mapView.addAnnotations(users)
    }


    func annotationView(annotation: MKAnnotation) -> MKAnnotationView? {
        if let user = annotation as? User {
            guard let existingAnnotationView = observer?.mapView.dequeueReusableAnnotationView(withIdentifier: UserAnnotationView.identifier) else {
                return UserAnnotationView(annotation: user, reuseIdentifier: UserAnnotationView.identifier)
            }
            return existingAnnotationView
        }

        return nil
    }

    // MARK: Permissions & State

    var isAuthorized: Bool {
        let status = CLLocationManager.authorizationStatus()
        return status != CLAuthorizationStatus.denied && status != CLAuthorizationStatus.restricted
    }

    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    // MARK: Notifications

    func notificationAppResignActive() {
        guard isAuthorized else { return }
        locationManager.stopUpdatingLocation()
    }

    func notificationAppBecomingActive() {
        guard isAuthorized else { return }
        locationManager.startUpdatingLocation()
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
