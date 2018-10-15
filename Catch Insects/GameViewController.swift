//
//  ViewController.swift
//  Catch Insects
//
//  Created by Kirill Koleno on 14/10/2018.
//  Copyright © 2018 i17215. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class GameViewController: UIViewController, ARSCNViewDelegate {

    // MARK: - Properties
    
    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet weak var labelImageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    @IBOutlet weak var menuButton: UIButton! {
        didSet { setupView(view: menuButton) }
    }
    
    @IBOutlet weak var playButton: UIButton! {
        didSet { setupView(view: playButton) }
    }
    
    @IBOutlet weak var pauseButton: UIButton! {
        didSet { setupView(view: pauseButton) }
    }
    
    @IBOutlet weak var lifeView: UIView! {
        didSet { setupView(view: lifeView) }
    }
    
    @IBOutlet weak var lifeLabel: UILabel!
    
    @IBOutlet weak var scoreView: UIView!{
        didSet { setupView(view: scoreView) }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - Life circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.debugOptions = .showFeaturePoints
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func setupView(view: UIView) {
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.5
    }
    
    // MARK: - Actions
    
    private func showMainSceneButtons() {
        
        if progressView.isHidden && loadingLabel.isHidden {
            
            UIView.animate(withDuration: 1.5, delay: 0, options: [], animations: {
                
                let yMenuButton = self.view.frame.minY + self.menuButton.frame.height + 20
                let yPlayButton = self.view.frame.maxY - self.playButton.frame.maxY - 16

                self.menuButton.transform = CGAffineTransform(translationX: 0, y: yMenuButton)
                self.playButton.transform = CGAffineTransform(translationX: 0, y: yPlayButton)
            })
        }
    }
    
    private func showGameSceneButtons() {
        
        UIView.animate(withDuration: 1.5) {
            
            self.menuButton.alpha = 0
            self.playButton.alpha = 0
            self.labelImageView.alpha = 0
            
            if self.menuButton.alpha == 0 && self.playButton.alpha == 0 {
                
                self.menuButton.isHidden = true
                self.playButton.isHidden = true
                self.labelImageView.isHidden = true
            }
            
            let xLifeView = self.view.frame.minX + self.lifeView.frame.width + 70
            let yPauseButton = self.view.frame.minY + self.pauseButton.frame.height + 10
            let xScoreView = self.view.frame.maxX - self.scoreView.frame.maxX - 20
            
            self.lifeView.transform = CGAffineTransform(translationX: xLifeView, y: 0)
            self.pauseButton.transform = CGAffineTransform(translationX: 0, y: yPauseButton)
            self.scoreView.transform = CGAffineTransform(translationX: xScoreView, y: 0)
        }
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        
        showGameSceneButtons()
    }

    // MARK: - ARSCNViewDelegate
    
    // Catch when plane is detected
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if anchor.isKind(of: ARPlaneAnchor.self) {
            
            DispatchQueue.main.async {
                
                UIView.animate(withDuration: 3, animations: {
                    
                    self.progressView.alpha = 0
                    self.loadingLabel.alpha = 0
                    
                    if self.progressView.alpha == 0 && self.loadingLabel.alpha == 0 {
                        
                        self.progressView.isHidden = true
                        self.loadingLabel.isHidden = true
                    }
                })
                
                self.showMainSceneButtons()
            }
        }
    }
}
