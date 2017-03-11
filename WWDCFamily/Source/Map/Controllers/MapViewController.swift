import UIKit
import FirebaseAuthUI
import MapKit

final class MapViewController: UIViewController, RootChildViewController {

    private let datasource = MapDataSource()

    override func loadView() {
        let view = UIView.instanceFromNib() as MapView
        self.view = view
    }

    var mapView: MKMapView {
        return (self.view as! MapView).mapView
    }

    // MARK: VC

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        title = "MapVC.Title".localized
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "locIcon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(MapViewController.didTapCurrentLocationBarButton))

        mapView.setRegion(datasource.sfRegion, animated: true)
        mapView.showsUserLocation = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .done, target: self, action: #selector(signOut))
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        datasource.requestLocationPermission()
    }

    // MARK: UI Events

    func didTapCurrentLocationBarButton() {
        presentLocationPermissionAlertIfNeeded()
        guard let currentLocation = datasource.currentLocation else { return }
        mapView.setRegion(datasource.zoomed(coordinate: currentLocation.coordinate), animated: true)
    }

    // MARK: Alerts

    func signOut() {
        do {
            let authUI = FUIAuth.defaultAuthUI()
            try authUI?.signOut()
            NotificationCenter.default.post(name: Session.unauthorizedNotificationName, object: nil)
        } catch let error {
            // This error is most likely a network error, so retrying here makes more sense.
            // TODO: Implement retrying.
            fatalError("Could not sign out: \(error)")
        }
    }

    private func presentLocationPermissionAlertIfNeeded() {
        guard !datasource.isAuthorized else { return }
        let alert = UIAlertController(title: "LocationDisabledAlert.Title".localized, message: "LocationDisabledAlert.Body".localized, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "General.OK".localized, style: UIAlertActionStyle.default, handler: { (_) -> Void in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }

}

extension MapViewController: MapDataObserver {
    func didChange(location: CLLocation) {

    }
}
