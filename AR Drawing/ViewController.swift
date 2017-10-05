//
//  ViewController.swift
//  AR Drawing
//
//  Created by Bryan Tobin on 2017-10-04.
//  Copyright © 2017 Bryan Tobin. All rights reserved.
//

import UIKit
import ARKit
class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var draw: UIButton!
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.showsStatistics = true
        self.sceneView.session.run(configuration)
        self.sceneView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        print("rendering")
        guard let pointOfView = sceneView.pointOfView else {return}
        let transform = pointOfView.transform
        let orientation = SCNVector3(-transform.m31,-transform.m32,-transform.m33) //where your phone is facing, how it is oriented. Orientation is when you rotate around itself, where the phone is facing when you are not actually moving the phone to a new location
        let location = SCNVector3(transform.m41,transform.m42,transform.m43) //where your phone is located relative to the scene view, how its moving translationally.  Location is when the phone actually changes location, when it moves translationally.
        let currentPositionOfCamera = orientation + location //Combine location and orientation togethr and you get your full position
        print(orientation.x, orientation.y, orientation.z)
    }
    
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
    
}

