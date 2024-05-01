//
//  ColorMixController.swift
//  TreasureHunt
//
//  Created by Syafrie Bachtiar on 30/04/24.
//

import UIKit
import SwiftUI

protocol ColorMixDelegate {
    //func didTapButton()
}

class ColorMixController: UIViewController {
    var delegate: ColorMixDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swiftUIView = ContentView(redSlider: 0, greenSlider: 0, blueSlider: 0)
        let hostingController = UIHostingController(rootView: swiftUIView)

        // Embed the SwiftUI view inside the UIKit view controller
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
    
    @IBAction func showSwiftUIView(_ sender: Any) {
        let swiftUIView = ContentView(redSlider: 0, greenSlider: 0, blueSlider: 0)
        let hostingController = UIHostingController(rootView: swiftUIView)
        navigationController?.pushViewController(hostingController, animated: true)
        print("Page ColorMix terbuka")
    }
    
    
    
    
}
