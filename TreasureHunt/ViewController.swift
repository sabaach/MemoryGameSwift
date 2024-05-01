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


class ViewController: UIViewController, ARSCNViewDelegate, ColorMixDelegate, gameViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        sceneView.delegate = self
        
        sceneView.showsStatistics = true
        
//        AudioManagerMain.shared.playBackgroundMusic(filename: "â We are! (Orchestra) One Piece")
        
        //Membuat 3 objek bulan
        createMoonObject(position: SCNVector3(x: 0, y: 0.1, z: -1))
        createTreasureObject(position: SCNVector3(x: -1, y: 0.1, z: -1))
        createTreasure1Object(position: SCNVector3(x: 2, y: 0.1, z: -1))
        
        createCloneObject(position: SCNVector3(x: 3, y: 0.1, z: -1))
        createCloneObject1(position: SCNVector3(x: 4, y: 0.1, z: -1))
        createCloneObject2(position: SCNVector3(x: 5, y: 0.1, z: -1))
        createCloneObject3(position: SCNVector3(x: 6, y: 0.1, z: -1))
        createCloneObject4(position: SCNVector3(x: 7, y: 0.1, z: -1))
        
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
                    sceneView.session.pause()
                    self.performSegue(withIdentifier: "toMemory", sender: nil)
                    
                }
                
                else if hitResult.node.geometry is SCNCone {
                    print("CollectStar")
                    sceneView.session.pause()
//                    let textNode = createTextNode(text: "Terima kasih")
//                    textNode.position = hitResult.node.position
//                    sceneView.scene.rootNode.addChildNode(textNode)
                    self.performSegue(withIdentifier: "toStar", sender: nil)
                }
                
                else if hitResult.node.geometry is SCNSphere {
                    print("ColorMix")
                    sceneView.session.pause()
//                    let textNode = createTextNode(text: "TRY AGAINNN")
//                    textNode.position = hitResult.node.position
//                    sceneView.scene.rootNode.addChildNode(textNode)
                    self.performSegue(withIdentifier: "toColorMix", sender: nil)
                }
                
                //CLONE OBJECT
                
                else if let geometry = hitResult.node.geometry {
                    switch geometry {
                        case is SCNBox, is SCNTube, is SCNTorus, is SCNCylinder, is SCNPyramid, is SCNCapsule, is SCNSphere:
                        print("TRY AGAINNN")
                        hitResult.node.removeFromParentNode()
                        return // Return untuk menghindari pemrosesan lebih lanjut
                        default:
                            break
                        }
                }
                
//                else if hitResult.node.geometry is SCNSphere {
//                    print("ColorMix")
//                    let textNode = createTextNode(text: "TRY AGAINNN")
//                    textNode.position = hitResult.node.position
//                    sceneView.scene.rootNode.addChildNode(textNode)
//                }
//                
//                
//                else if hitResult.node.geometry is SCNTube {
//                    print("TUBE")
//                    let textNode = createTextNode(text: "TRY AGAINNN")
//                    textNode.position = hitResult.node.position
//                    sceneView.scene.rootNode.addChildNode(textNode)
//                }
//                else if hitResult.node.geometry is SCNTorus {
//                    print("TORUS")
//                    let textNode = createTextNode(text: "TRY AGAINNN")
//                    textNode.position = hitResult.node.position
//                    sceneView.scene.rootNode.addChildNode(textNode)
//                }
//                else if hitResult.node.geometry is SCNCylinder {
//                    print("CYLINDER")
//                    let textNode = createTextNode(text: "TRY AGAINNN")
//                    textNode.position = hitResult.node.position
//                    sceneView.scene.rootNode.addChildNode(textNode)
//                }
//                else if hitResult.node.geometry is SCNPyramid {
//                    print("PYRAMID")
//                    let textNode = createTextNode(text: "TRY AGAINNN")
//                    textNode.position = hitResult.node.position
//                    sceneView.scene.rootNode.addChildNode(textNode)
//                }
//                else if hitResult.node.geometry is SCNCapsule {
//                    print("CAPSULE")
//                    let textNode = createTextNode(text: "TRY AGAINNN")
//                    textNode.position = hitResult.node.position
//                    sceneView.scene.rootNode.addChildNode(textNode)
//                }
                
            }
        }
    }
    
    // Metode untuk menempatkan SCNNode di atas permukaan lantai
    func placeNodeOnFloor(at position: SCNVector3, for node: SCNNode) {
        let planeNode = SCNNode(geometry: SCNPlane(width: 1, height: 1))
        planeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.clear // Menjadikan material transparan
        planeNode.eulerAngles.x = -.pi / 2 // Rotasi node agar sejajar dengan lantai
        
        // Atur posisi SCNNode di atas permukaan lantai
        planeNode.position = position
        sceneView.scene.rootNode.addChildNode(planeNode)
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
        
        placeNodeOnFloor(at: position, for: node)
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
        
        placeNodeOnFloor(at: position, for: node1)
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
        
        placeNodeOnFloor(at: position, for: node2)
    }
    
    func createCloneObject(position: SCNVector3) {
        let tube = SCNTube(innerRadius: 0.5, outerRadius: 0.5, height: 1)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/treasure.jpg")
        tube.materials = [material]
        
        let node3 = SCNNode()
        node3.position = position
        node3.geometry = tube
        sceneView.scene.rootNode.addChildNode(node3)
        
        placeNodeOnFloor(at: position, for: node3)
    }
    
    func createCloneObject1(position: SCNVector3) {
        let cylinder = SCNCylinder(radius: 0.5, height: 1)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/treasure.jpg")
        cylinder.materials = [material]
        
        let node4 = SCNNode()
        node4.position = position
        node4.geometry = cylinder
        sceneView.scene.rootNode.addChildNode(node4)
        
        placeNodeOnFloor(at: position, for: node4)
    }
    
    func createCloneObject2(position: SCNVector3) {
        let pyramid = SCNPyramid(width: 1, height: 1, length: 1)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/treasure.jpg")
        pyramid.materials = [material]
        
        let node5 = SCNNode()
        node5.position = position
        node5.geometry = pyramid
        sceneView.scene.rootNode.addChildNode(node5)
        
        placeNodeOnFloor(at: position, for: node5)
    }
    
    func createCloneObject3(position: SCNVector3) {
        let capsule = SCNCapsule(capRadius: 0.5, height: 1)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/treasure.jpg")
        capsule.materials = [material]
        
        let node6 = SCNNode()
        node6.position = position
        node6.geometry = capsule
        sceneView.scene.rootNode.addChildNode(node6)
        
        placeNodeOnFloor(at: position, for: node6)
    }
    
    func createCloneObject4(position: SCNVector3) {
        let torus = SCNTorus(ringRadius: 0.5, pipeRadius: 0.5)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/treasure.jpg")
        torus.materials = [material]
        
        let node7 = SCNNode()
        node7.position = position
        node7.geometry = torus
        sceneView.scene.rootNode.addChildNode(node7)
        
        placeNodeOnFloor(at: position, for: node7)
    }
   
    func createTextNode(text: String) -> SCNNode {
        let textGeometry = SCNText(string: text, extrusionDepth: 1.0)
        textGeometry.firstMaterial?.diffuse.contents = UIColor.white
        
        let textNode = SCNNode(geometry: textGeometry)
        //Scale textnode (x,y,z)
        textNode.scale = SCNVector3(0.005, 0.005, 0.005)
        //Set Posisi textnode (x,y,z)
        textNode.position = SCNVector3(0, 0.1, -1)
        
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
                colorMixController.delegate = self
                colorMixController.modalPresentationStyle = .fullScreen
            }
        }
        
    }
    
    //public var firstButtonAction: ((_ url:String) -> Void)?
    
//    deinit {
//            AudioManagerMain.shared.stopBackgroundMusic()
//        }
    
}

extension ViewController: 
    MemoryDelegate {
    func gameIsFinish() {
        print("game is finish")
    }
    
}
