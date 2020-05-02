//
//  ARViewController.swift
//  ARLocation
//
//  Created by zein rezky chandra on 02/05/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let coachingOverlay = ARCoachingOverlayView()
    
    var refObject = SCNReferenceNode()
    
    var session: ARSession {
        return sceneView.session
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run view's session
        sceneView.session.run(configuration, options: .resetTracking)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause view's session
        sceneView.session.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupARScene()
    }

}

// MARK: AR Scene Configuration

extension ARViewController {
    func setupARScene() {
        // assign the delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // debug options
        sceneView.debugOptions = [
            ARSCNDebugOptions.showFeaturePoints,
            ARSCNDebugOptions.showWorldOrigin
        ]
        
        // Add 3D Square Object to scene view as a child node
        add3DSquare()
        
        // Add Ship AR Assets object to scene view as a child node
        addShip()
    }
    
    func createSphereNode(with radius: CGFloat, color: UIColor) -> SCNNode {
        let geometry = SCNSphere(radius: radius)
        geometry.firstMaterial?.diffuse.contents = color
        let sphereNode = SCNNode(geometry: geometry)
        return sphereNode
    }
    
    func add3DSquare() {
        // Create a new scene and set it to the view
        sceneView.scene = SCNScene()
        
        // Create a blue spherical node with a 0.2m radius
        let circleNode = createSphereNode(with: 0.2, color: .blue)
        
        // Position it 1 meter in front of camera
        circleNode.position = SCNVector3(0, 0, -1)
        
        // Add the node to the AR scene
        sceneView.scene.rootNode.addChildNode(circleNode)
    }
    
    func addShip() {
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        sceneView.scene = scene
        sceneView.isPlaying = true
    }
}

// MARK: AR Scene Delegate

extension ARViewController: ARSCNViewDelegate {
    func session(_ session: ARSession, didFailWithError error: Error) {
        print("ARSession didFailWithError: %@", error)
        let alertController = UIAlertController(title: "ARSession Error", message: error.localizedDescription, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        print("ARSession sessionWasInterrupted")
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        print("ARSession sessionInterruptionEnded")
    }
}
