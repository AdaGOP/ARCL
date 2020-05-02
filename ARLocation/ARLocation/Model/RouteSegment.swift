//
//  RouteSegment.swift
//  ARLocation
//
//  Created by zein rezky chandra on 03/05/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import CoreLocation

struct RouteSegment {
    var startLatitude: CLLocationDegrees
    var startLongitude: CLLocationDegrees
    var startAltitude: CLLocationDegrees
    
    var endLatitude: CLLocationDegrees
    var endLongitude: CLLocationDegrees
    var endAltitude: CLLocationDegrees
}
