//
//  ViewController.swift
//  FaceIt
//
//  Created by Junseok Lee on 2021/08/27.
//

import UIKit

class FaceViewController: UIViewController {

    var expression = FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk){
        didSet{
            updateUI()
        }
    }
    @IBOutlet weak var faceView: FaceView!{
        didSet{
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(recognizer:))))
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.increaseHappiness))
            happierSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(FaceViewController.decreaseHappiness))
            sadderSwipeGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            updateUI()
        }
    }
    @IBAction func toggleEyes(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended{
            switch expression.eyes{
            case .Open :expression.eyes = .Closed
            case .Closed: expression.eyes = .Open
            case .Squinting : break
            }
        }
    }
    
    @objc func increaseHappiness(){
        expression.mouth = expression.mouth.happierMouth()
    }
    
    @objc func decreaseHappiness(){
        expression.mouth = expression.mouth.sadderMouth()
    }

    
    private var mouthCurvatures = [FacialExpression.Mouth.Frown : -1.0, .Grin: 0.5, .Smile : 1.0 ,.Smirk: -0.5, .Neutral: 0.0]
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed:0.5,.Furrowed:-0.5,.Normal:0.0]
    private func updateUI() {
        switch expression.eyes{
        case .Open : faceView.eyeOpen = true
        case .Closed : faceView.eyeOpen = false
        case .Squinting : faceView.eyeOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    }
}

