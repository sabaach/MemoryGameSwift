//
//  ViewController.swift
//  TreasureHunt
//
//  Created by Syafrie Bachtiar on 28/04/24.
//

import UIKit
import SceneKit
import ARKit
import SwiftUI

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        sceneView.delegate = self
        
        sceneView.showsStatistics = true
        
        //Membuat 3 objek bulan
        createMoonObject(position: SCNVector3(x: 0, y: 0.1, z: -10))
        createTreasureObject(position: SCNVector3(x: -1, y: 0.1, z: -5))
        createTreasure1Object(position: SCNVector3(x: 2, y: 0.1, z: -10))
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
                //Objek Per MiniGame
                if hitResult.node.geometry is SCNBox {
                    print("Memory!")
                    self.performSegue(withIdentifier: "toMemory", sender: nil)
                }
                else if hitResult.node.geometry is SCNSphere {
                    print("ColorMix")
                    let textNode = createTextNode(text: "Terima kasih")
                    textNode.position = hitResult.node.position
                    sceneView.scene.rootNode.addChildNode(textNode)
                }
                else if hitResult.node.geometry is SCNCone {
                    print("CollectStar")
//                    let textNode = createTextNode(text: "Terima kasih")
//                    textNode.position = hitResult.node.position
//                    sceneView.scene.rootNode.addChildNode(textNode)
                    self.performSegue(withIdentifier: "tostar", sender: nil)
                }
                
            }
        }
    }
    
    func createMoonObject(position: SCNVector3) {
        let cube = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0.0)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/treasure.jpg")
        cube.materials = [material]
        
        let node = SCNNode()
        node.position = position
        node.geometry = cube
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    func createTreasureObject(position: SCNVector3) {
        let sphere = SCNSphere(radius: 0.5)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/treasure.jpg")
        sphere.materials = [material]
        
        let node1 = SCNNode()
        node1.position = position
        node1.geometry = sphere
        sceneView.scene.rootNode.addChildNode(node1)
    }
    
    func createTreasure1Object(position: SCNVector3) {
        let cone = SCNCone(topRadius: 0.5, bottomRadius: 0.5, height: 1)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/treasure.jpg")
        cone.materials = [material]
        
        let node2 = SCNNode()
        node2.position = position
        node2.geometry = cone
        sceneView.scene.rootNode.addChildNode(node2)
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toMemory") {
            if let memoryViewController = segue.destination as? MemoryController {
                memoryViewController.delegate = self
                memoryViewController.modalPresentationStyle = .fullScreen
            }
        }
        else if (segue.identifier == "toStar") {
            if let gameViewController = segue.destination as? GameViewController {
                gameViewController.delegate = self
                gameViewController.modalPresentationStyle = .fullScreen
            }
        }
        else if (segue.identifier == "toColorMix") {
            if let colorMixController = segue.destination as? ColorMixController {
                //colorMixController.delegate = self
            }
        }
        
    }
    
    //public var firstButtonAction: ((_ url:String) -> Void)?
    
    
}

extension ViewController: MemoryDelegate {
    func gameIsFinish() {
        print("game is finish")
    }
}
