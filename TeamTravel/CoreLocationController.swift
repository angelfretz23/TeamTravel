//
//  CoreLocationController.swift
//  TeamTravel
//
//  Created by Joseph Hansen on 10/25/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import Foundation
import CoreLocation

class CoreLocationController: NSObject, CLLocationManagerDelegate {
    
    static let shared = CoreLocationController()
    
    var locationManager: CLLocationManager?
    
    var currentTravelerLocation: CLLocation? {
        didSet{
            let notification = Notification(name: Notification.Name(rawValue: "currentLocationUpdated"))
            NotificationCenter.default.post(notification)
        }
    }
    
    var hasAccess: Bool {
//        locationManager?.requestAlwaysAuthorization()
        return checkForAuthorizationStatus()
    }
    
    func checkForAuthorizationStatus() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            return true
        case .authorizedWhenInUse:
            return false
        case .denied:
            return false
        case .notDetermined:
            return false
        case .restricted:
            return false
        }
    }
    
/// sets up locationManager to be delegate, sets accuracy to be within 10 Meters
    func setupLocationManager() {
        let locMan = CLLocationManager()
        locMan.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locMan.distanceFilter = 10
        locMan.delegate = self
        self.locationManager = locMan
        getCurrentLocation()
    }
    
/// checks Authorization status each time
    func getCurrentLocation() {
        
        if hasAccess == true {
            locationManager?.requestLocation()
        } else {
            locationManager?.requestAlwaysAuthorization()
        }
    }
    
    func registerGeoFence(for location: Location) {
        let region = location.createRegion()
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            locationManager?.startMonitoring(for: region)
        } else {
            NSLog("no monitoring available")
        }
    }
    
    func unregisterGeoFence(for location: Location) {
        let region = location.createRegion()
        
        locationManager?.stopMonitoring(for: region)
    }
    
    func unregisterAllGeoFences() {
        guard let locationManager = locationManager else { return }
        for region in locationManager.monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            NSLog("Got User Location")
            
            if let location = locations.first {
                self.currentTravelerLocation = location
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog(error.localizedDescription)
    }

}
