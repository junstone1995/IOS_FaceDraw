//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Junseok Lee on 2021/09/01.
//

import UIKit

class EmotionsViewController: UIViewController {

    private let emotionalFaces:Dictionary<String,FacialExpression> = [
        "angry" : FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
        "happy" : FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
        "worried" : FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
        "mischievious" : FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin)]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVc = segue.destination
        if let navcon = destinationVc as? UINavigationController{
            destinationVc = navcon.visibleViewController ?? destinationVc
        }
        if let facevc = destinationVc as? FaceViewController{
            if let identifier = segue.identifier{
                if let expression = emotionalFaces[identifier]{
                    facevc.expression = expression
                    if let sendingButton = sender as? UIButton{
                        facevc.navigationItem.title = sendingButton.currentTitle
                    }
                }
            }
        }
    }
}
