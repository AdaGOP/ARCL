//
//  SceneLocationEstimate.swift
//  ARLocation
//
//  Created by zein rezky chandra on 03/05/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import CoreLocation
import SceneKit

public class SceneLocationEstimate {
    public let location: CLLocation
    public let position: SCNVector3

    init(location: CLLocation, position: SCNVector3) {
        self.location = location
        self.position = position
    }
}

public struct LocationTranslation {
    public var latitudeTranslation: Double
    public var longitudeTranslation: Double
    public var altitudeTranslation: Double

    public init(latitudeTranslation: Double, longitudeTranslation: Double, altitudeTranslation: Double) {
        self.latitudeTranslation = latitudeTranslation
        self.longitudeTranslation = longitudeTranslation
        self.altitudeTranslation = altitudeTranslation
    }
}

