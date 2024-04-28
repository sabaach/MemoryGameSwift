//
//  ViewController.swift
//  TreasureHunt
//
//  Created by Syafrie Bachtiar on 28/04/24.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        sceneView.delegate = self
        
        sceneView.showsStatistics = true
        
        //Membuat 3 objek bulan
        createMoonObject(position: SCNVector3(x: 0, y: 0.1, z: -0.5))
        createMoonObject(position: SCNVector3(x: -0.5, y: 0.1, z: -0.5))
        createMoonObject(position: SCNVector3(x: 0.5, y: 0.1, z: -0.5))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
                   let touchLocation = touch.location(in: sceneView)
                   
                   let results = sceneView.hitTest(touchLocation, options: nil)
                   if let hitResult = results.first {
                       if hitResult.node.geometry is SCNSphere {
                           print("Touched the moon!")
                           let textNode = createTextNode(text: "Terima kasih")
                           textNode.position = hitResult.node.position
                           sceneView.scene.rootNode.addChildNode(textNode)
                       }
                   }
               }
           }
    
    func createMoonObject(position: SCNVector3) {
        let cube = SCNSphere(radius: 0.1)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/8k_moon.jpg")
        cube.materials = [material]
        
        let node = SCNNode()
        node.position = position
        node.geometry = cube
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    func createTextNode(text: String) -> SCNNode {
        let textGeometry = SCNText(string: text, extrusionDepth: 1.0)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.white
        
        let textNode = SCNNode(geometry: textGeometry)
        //Scale textnode (x,y,z)
        textNode.scale = SCNVector3(0.005, 0.005, 0.005)
        //Set Posisi textnode (x,y,z)
        textNode.position = SCNVector3(0, 0.1, 0) 
        
        return textNode
    }
}
