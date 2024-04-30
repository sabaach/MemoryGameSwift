//
//  MemoryController.swift
//  TreasureHunt
//
//  Created by Syafrie Bachtiar on 30/04/24.
//

import UIKit


protocol MemoryDelegate {
    func gameIsFinish()
}

class MemoryController: UIViewController {
    
    var delegate: MemoryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate?.gameIsFinish()
    }
    
    
    
}
