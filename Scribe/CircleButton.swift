//
//  CircleButton.swift
//  Scribe
//
//  Created by Kimar Arakaki Neves on 2016-12-07.
//  Copyright © 2016 Kimar. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 32.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius

    }
}
