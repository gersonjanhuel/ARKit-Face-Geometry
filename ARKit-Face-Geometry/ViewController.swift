//
//  ViewController.swift
//  ARKit-Face-Geometry
//
//  Created by Gerson Janhuel on 16/05/20.
//  Copyright © 2020 Elcode Studio. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var faceView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faceView.delegate = self
        guard ARFaceTrackingConfiguration.isSupported else {
            print("ARFaceTrackingConfiguration is not supported on this device")
            return
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARFaceTrackingConfiguration()
        faceView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        faceView.session.pause()
    }
}


extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let device = faceView.device else {
            return nil
        }
        
        let faceGeometry = ARSCNFaceGeometry(device: device)
        let faceNode = SCNNode(geometry: faceGeometry)
        faceNode.geometry?.firstMaterial?.fillMode = .lines
        return faceNode
    }
}
