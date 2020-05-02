//
//  LocationNode.swift
//  ARLocation
//
//  Created by zein rezky chandra on 03/05/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation
import SceneKit
import CoreLocation

open class LocationNode: SCNNode {
    public var location: CLLocation!
    
    public var tag: String?
    
    public var locationConfirmed = false
    
    public var continuallyAdjustNodePositionWhenWithinRange = true
    
    public var continuallyUpdatePositionAndScale = true
    
    public var scaleRelativeToDistance = false
    
    public init(location: CLLocation?) {
        self.location = location
        self.locationConfirmed = location != nil
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class LocationAnnotationNode: LocationNode {
    public let image: UIImage
    
    public let annotationNode: SCNNode
    
    public init(location: CLLocation?, image: UIImage) {
        self.image = image
        
        let plane = SCNPlane(width: image.size.width / 100, height: image.size.height / 100)
        plane.firstMaterial!.diffuse.contents = image
        plane.firstMaterial!.lightingModel = .constant
        
        annotationNode = SCNNode()
        annotationNode.geometry = plane
        
        super.init(location: location)
        
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = SCNBillboardAxis.Y
        constraints = [billboardConstraint]
        
        addChildNode(annotationNode)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
