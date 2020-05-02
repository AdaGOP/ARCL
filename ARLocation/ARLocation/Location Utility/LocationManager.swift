//
//  LocationManager.swift
//  ARLocation
//
//  Created by zein rezky chandra on 03/05/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: class {
    func locationManagerDidUpdateLocation(_ locationManager: LocationManager, location: CLLocation)
    func locationManagerDidUpdateHeading(_ locationManager: LocationManager, heading: CLLocationDirection, accuracy: CLLocationDirection)
}

public class LocationManager: NSObject, CLLocationManagerDelegate {
    weak var delegate: LocationManagerDelegate?

    private var locationManager: CLLocationManager?

    var currentLocation: CLLocation?

    private(set) public var heading: CLLocationDirection?
    private(set) public var headingAccuracy: CLLocationDegrees?

    override init() {
        super.init()

        self.locationManager = CLLocationManager()
        self.locationManager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager!.distanceFilter = kCLDistanceFilterNone
        self.locationManager!.headingFilter = kCLHeadingFilterNone
        self.locationManager!.pausesLocationUpdatesAutomatically = false
        self.locationManager!.delegate = self
        self.locationManager!.startUpdatingHeading()
        self.locationManager!.startUpdatingLocation()

        self.locationManager!.requestWhenInUseAuthorization()

        self.currentLocation = self.locationManager!.location
    }

    func requestAuthorization() {
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse {
            return
        }

        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.denied ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.restricted {
            return
        }

        self.locationManager?.requestWhenInUseAuthorization()
    }

    // MARK: - CLLocationManagerDelegate

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            self.delegate?.locationManagerDidUpdateLocation(self, location: location)
        }

        self.currentLocation = manager.location
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if newHeading.headingAccuracy >= 0 {
            self.heading = newHeading.trueHeading
        } else {
            self.heading = newHeading.magneticHeading
        }

        self.headingAccuracy = newHeading.headingAccuracy

        self.delegate?.locationManagerDidUpdateHeading(self, heading: self.heading!, accuracy: newHeading.headingAccuracy)
    }

    public func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
}
