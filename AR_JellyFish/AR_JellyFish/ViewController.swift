//
//  ViewController.swift
//  AR_JellyFish
//
//  Created by Jack Wong on 2018/04/12.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit
import ARKit
import Each

class ViewController: UIViewController {
    
    var timer = Each(1).seconds
    let configuration = ARWorldTrackingConfiguration()
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    private var score = 0
    private var countDown = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConfiguration()
        setupTapGestureRegonizer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapPlay(_ sender: Any) {
        play.isEnabled = false 
        addNode()
        setTime()
    }
    
    @IBAction func didTapReset(_ sender: Any) {
        self.timer.stop()
        restoreTimer()
        score = 0
        scoreLabel.text = "Score: \(score)"
        timeLabel.text = "Let's Play!!"
        play.isEnabled = true
        sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
    }
    
    
}

extension ViewController: ARSCNViewDelegate {
    private func setupConfiguration() {
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        //sceneView.showsStatistics = true
        sceneView.session.run(configuration)
    }
}

extension ViewController {
    private func setupTapGestureRegonizer(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc private func handleTap(sender: UITapGestureRecognizer){
        
        let sceneViewTappedOn = sender.view as! SCNView
        let touchCoordinates = sender.location(in: sceneViewTappedOn)
        let hitTest = sceneViewTappedOn.hitTest(touchCoordinates)
        if hitTest.isEmpty {
            print("didnt touch anything")
        } else if (hitTest.first!.node.name == "jellyFish") {
            if countDown > 0 {
            let result = hitTest.first!
                print(result)
                
            let node = result.node
                
            // when animating , animationKey is not empty
            if node.animationKeys.isEmpty {
                
                SCNTransaction.begin()
                self.animateNode(node: node)
                SCNTransaction.completionBlock = {
                node.removeFromParentNode()
                self.addNode()
                self.restoreTimer()
                self.addScore()
                }
                SCNTransaction.commit()
                
            }
        }
        }
    }
    private func animateNode(node: SCNNode) {
        let spin = CABasicAnimation(keyPath: "position")
        spin.fromValue = node.presentation.position
        // Relative to World Origin
        //spin.toValue = SCNVector3(0,0,-2)
        //Relative to Node
        spin.toValue = SCNVector3(node.presentation.position.x - 0.2 ,node.presentation.position.y - 0.2 ,node.presentation.position.z - 0.2)
        spin.duration = 0.07
        spin.repeatCount = 5
        // make sure come back to initial position
        spin.autoreverses = true
        node.addAnimation(spin, forKey: "position")
        
    }
    
    private func addNode() {
        let jellyFishScene = SCNScene(named: "art.scnassets/Jellyfish.scn")
        let jellyFishNode = jellyFishScene?.rootNode.childNode(withName: "JellyFish", recursively: false)
        jellyFishNode?.position = SCNVector3(randomNumber(firstNum: -1, secondNum: 1),randomNumber(firstNum: -0.5, secondNum: 0.5),randomNumber(firstNum: -1, secondNum: 1))
        jellyFishNode?.name = "jellyFish"
        sceneView.scene.rootNode.addChildNode(jellyFishNode!)
    }
    
    private func randomNumber(firstNum: CGFloat, secondNum: CGFloat ) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min (firstNum,secondNum)
    }
    
    private func setTime() {
        self.timer.perform { () -> NextStep in
            self.countDown -= 1
            self.timeLabel.text = String(self.countDown)
            if self.countDown == 0 {
                self.timeLabel.text = "You Lose"
                return .stop
            }
            return .continue
        }
    }
    private func restoreTimer() {
        self.countDown = 10
        self.timeLabel.text = String(self.countDown)
    }
    private func addScore(){
    self.score += 1
    self.scoreLabel.text = "Score: \(self.score)"
    }
    
}
