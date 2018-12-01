//
//  ViewController.swift
//  CGAffineTransformTest
//
//  Created by Sarthak Tayade on 27/11/18.
//  Copyright © 2018 Sarthak Tayade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView?

    @IBOutlet weak var matrixInterpolationSlider: UISlider?
    @IBOutlet weak var angleInterpolationSlider: UISlider?

    @IBOutlet weak var matrixInterpolationValuesLabel: UILabel?
    @IBOutlet weak var angleInterpolationValuesLabel: UILabel?

    private let finalAngle = (160 / 180 * CGFloat.pi)

    override func viewDidLoad() {
        super.viewDidLoad()
        matrixInterpolationSlider?.value = 0.0
        angleInterpolationSlider?.value = 0.0
    }

    @objc
    @IBAction func matrixInterpolationSliderChanged(slider: UISlider) {
        applyMatrixLinearInterpolationAffineTransform(for: CGFloat(slider.value))
    }

    @objc
    @IBAction func angleInterpolationSliderChanged(slider: UISlider) {
        applyAngleInterpolationTrasform(for: CGFloat(slider.value))
    }

    @objc
    @IBAction func runUIViewAnimationButtonTapped() {
        imageView?.transform = CGAffineTransform.identity
        UIView.animate(withDuration: 3.0, animations: {
            self.imageView?.transform = CGAffineTransform.init(rotationAngle: self.finalAngle)
        })
    }

    /**
     Interpolates values of the CGAffineTransform matrix linearly for rotation from 0 to 160.
     */
    private func applyMatrixLinearInterpolationAffineTransform(for value: CGFloat) {
        let initialAngle: CGFloat = 0.0

        let aFrom: CGFloat = cos(initialAngle)
        let aTo: CGFloat = cos(finalAngle)

        let bFrom: CGFloat = sin(initialAngle)
        let bTo: CGFloat = sin(finalAngle)

        let cFrom: CGFloat = sin(initialAngle) * -1
        let cTo: CGFloat = sin(finalAngle) * -1

        let dFrom: CGFloat = cos(initialAngle)
        let dTo: CGFloat = cos(finalAngle)

        let a = map(x: value, fromMin: 0, fromMax: 1, toMin: aFrom, toMax: aTo);
        let b = map(x: value, fromMin: 0, fromMax: 1, toMin: bFrom, toMax: bTo);
        let c = map(x: value, fromMin: 0, fromMax: 1, toMin: cFrom, toMax: cTo);
        let d = map(x: value, fromMin: 0, fromMax: 1, toMin: dFrom, toMax: dTo);

        matrixInterpolationValuesLabel?.text = "[ \(a), \(b), \(c), \(d) ]"

        imageView?.transform = CGAffineTransform.init(a: a, b: b, c: c, d: d, tx: 0, ty: 0)
    }

    /**
     Interpolates values of the rotation angle from 0 to 160.
     */
    private func applyAngleInterpolationTrasform(for value: CGFloat) {
        let angle = map(x: value, fromMin: 0, fromMax: 1, toMin: 0, toMax: finalAngle)
        let transformationMatrix = CGAffineTransform.init(rotationAngle: angle)
        angleInterpolationValuesLabel?.text = "[ \(transformationMatrix.a), \(transformationMatrix.b), \(transformationMatrix.c), \(transformationMatrix.d) ]"
        imageView?.transform = transformationMatrix
    }

    private func map(x: CGFloat, fromMin: CGFloat, fromMax: CGFloat, toMin: CGFloat, toMax: CGFloat) -> CGFloat {
        return (((toMax - toMin) / (fromMax - fromMin)) * (x - fromMin)) + toMin
    }

}

