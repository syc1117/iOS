//
//  ImageAnimationViewController.swift
//  UIViewAnimation
//
//  Created by giftbot on 2020. 1. 7..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import UIKit

final class ImageAnimationViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var repeatCountLabel: UILabel!
    
    let images = [
        "AppStore", "Calculator", "Calendar", "Camera", "Clock", "Contacts", "Files"
        ].compactMap(UIImage.init(named: ))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.animationImages = images
    }
    
    @IBAction private func startAnimation(_ sender: Any) {
        imageView.startAnimating()
    }
    
    @IBAction private func stopAnimation(_ sender: Any) {
        imageView.stopAnimating()
    }
    
    @IBAction private func durationStepper(_ sender: UIStepper) {
        durationLabel.text = "\(sender.value)"
        //duration = 1일경우 배열의 한사이클 다 보여주는데 1초
        imageView.animationDuration = sender.value
    }
    
    @IBAction private func repeatCountStepper(_ sender: UIStepper) {
        repeatCountLabel.text = "\(Int(sender.value))"
        //animationRepeatCount = 1일 경우 한사이클만 보여주고 종료
        imageView.animationRepeatCount = Int(sender.value)
    }
}
