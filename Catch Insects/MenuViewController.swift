//
//  MenuViewController.swift
//  Catch Insects
//
//  Created by Kirill Koleno on 14/10/2018.
//  Copyright © 2018 i17215. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    let gameViewController = GameViewController()
    
    @IBOutlet weak var menuView: UIView! {
        didSet { gameViewController.setupView(view: menuView) }
    }
    
    @IBOutlet weak var backButton: UIButton! {
        didSet { gameViewController.setupView(view: backButton) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
