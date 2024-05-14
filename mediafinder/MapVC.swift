//
//  MapVC.swift
//  mediafinder
//
//  Created by ALY NABIL on 11/05/2024.
//

import MapKit
protocol sendLocation: AnyObject {
    func didSelectedLocation(_ data: String)
}

class MapVC: UIViewController {
    
    //MARK: - Outlets.
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    //MARK: - Properties.
    private let locationManager = CLLocationManager() // Must use locationManager
    var delegat: sendLocation?
    
    //MARK: - LifeCycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        checkLocationServices()
    }
    
    //MARK: - Actions.
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        let selectedLocation = addressLabel?.text ?? ""
        delegat?.didSelectedLocation(selectedLocation) 
    }
}

//MARK: -  MKMapViewDelegate
extension MapVC: MKMapViewDelegate {
    // this func to catch location whene the user movig
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let lat = mapView.centerCoordinate.latitude
        let long = mapView.centerCoordinate.longitude
        let location = CLLocation(latitude: lat, longitude: long)
        getAddressName(location: location) // called here to get user location whene he moving 
    }
    
}


//MARK: - Private Methods.
extension MapVC {
    private func checkLocationServices() { // This func to check if the location services is open or not
        if CLLocationManager.locationServicesEnabled() { // Ask if location services is enabled
            checkLocationAuthorisation()
        } else {
            print("can Not Get your Location")
        }
        
    }
    private func checkLocationAuthorisation() { // this func to check if the user make a permession to use his location or not
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined: // ask the user to allow location
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied: // the user denied location authorisation
            print("can Not Get your Location")
        case .authorizedAlways, .authorizedWhenInUse: // the user allow location authorisation
            centerOnUserCurrentLocation() // called here to set user current location
        @unknown default: // there is unknown case
            print("can Not Get your Location")
        }
    }
    private func centerOnSelectedLocation() { // This func when the user need to open on selected location
        let location = CLLocation(latitude: 30.096655, longitude: 31.662533) // to determine latitude & longitude
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000) // zome in 10000 * 10000 noting that i can write any numbers
        mapView.setRegion(region, animated: true) // to set the region
        getAddressName(location: location)
        
    }
    private func centerOnUserCurrentLocation() { // This func when the user need to open on current location
        if let location = locationManager.location {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000) // zome in 10000 * 10000 noting that i can write any numbers
            mapView.setRegion(region, animated: true) // to set the region
            getAddressName(location: location)
        }
        
    }
    private func getAddressName(location: CLLocation) { // this func to catch the user location
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { placMark, error in
            if let error = error {
                print("ERROR is: \(error.localizedDescription)")
            } else if let placMark = placMark?.first {
                self.addressLabel.text = placMark.compactAddress
            }
        }
        
    }
}

extension CLPlacemark { // extension placMark to catch name and city and country of user location
    var compactAddress: String? {
        if let name = name {
            var result = name
            if let street = thoroughfare {
                result += ", \(street)"
            }
            if let city = locality {
                result += ", \(city)"
            }
            if let country = country {
                result += ", \(country)"
            }
            return result
        }
        return nil
    }
}


