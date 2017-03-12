import UIKit
import MapKit

final class MapViewController: UIViewController, RootChildViewController {

    fileprivate let datasource = MapDataSource()

    @IBOutlet private(set) weak var mapView: MKMapView! {
        didSet {
            mapView.setRegion(datasource.sfRegion, animated: true)
        }
    }

    // MARK: VC

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        title = "MapVC.Title".localized
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "locIcon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(MapViewController.didTapCurrentLocationBarButton))

        datasource.observer = self
        datasource.refresh()
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

    private func presentLocationPermissionAlertIfNeeded() {
        guard !datasource.isAuthorized else { return }
        let alert = UIAlertController(title: "LocationDisabledAlert.Title".localized, message: "LocationDisabledAlert.Body".localized, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "General.OK".localized, style: UIAlertActionStyle.default, handler: { (_) -> Void in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }

}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return datasource.annotationView(annotation: annotation)
    }
}

extension MapViewController: MapDataObserver {
    func didChange(location: CLLocation) {

    }
}
