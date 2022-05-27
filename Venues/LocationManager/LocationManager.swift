//
//  LocationManager.swift
//  Venues
//
//  Created by Enas Ahmed Zaki on 27/05/2022.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation()
    func enableLocationPermission()
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    weak var delegate: LocationManagerDelegate?
    
    fileprivate let locationManager = CLLocationManager()
    var latitudeLongitude: String = "" // variable to define the user's current location
    var hasPermission: Bool = false
    
    func startUpdatingLocation() { // Start updating called from presenter
       
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
//        if CLLocationManager.locationServicesEnabled() {
//            switch locationManager.authorizationStatus {
//            case .authorizedAlways, .authorizedWhenInUse:
//                hasPermission = true
//            default:
//                break
//            }
//            self.updateLocationAfterPermission()
//
//        }
    }
    
    func updateLocationAfterPermission() {
        if hasPermission {
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.startUpdatingLocation()
        } else {
            self.delegate?.enableLocationPermission()
            
        }
    }
    
    func getCurrentLocation() -> String {
        // how can I catch a location?
        return latitudeLongitude
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            hasPermission = true
        case .notDetermined:
            return
        default:
            break
        }
        self.updateLocationAfterPermission()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.updateLocationAfterPermission()

    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        if self.latitudeLongitude != "\(locValue.latitude),\(locValue.longitude)" {
            
            self.latitudeLongitude = "\(locValue.latitude),\(locValue.longitude)"
            self.delegate?.didUpdateLocation() // Notify delegate on change
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
