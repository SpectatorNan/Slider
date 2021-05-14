//
//  SNSlider.swift
//  Slider
//
//  Created by 楠 on 2021/5/14.
//

import UIKit
import QuartzCore

class SNSlider: UIControl {
    
    var mininumValue = 0.0
    var maxnumValue = 1.0
    var currentValue = 0.2
    
    var trackTintColor = UIColor(white: 0.9, alpha: 1)
    var trackHighlightTintColor = UIColor.red
    var thumbTintColor = UIColor.white
    
    let trackLayer = SNSliderTrackLayer()
    let thumbLayer = SNSliderThumbLayer()
    
    var previousLocation = CGPoint()
    
    var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }
    
    var curvaceousness: CGFloat = 1.0 {
        didSet {
            trackLayer.setNeedsDisplay()
            thumbLayer.setNeedsDisplay()
        }
    }
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayerFrames()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackLayer.backgroundColor = UIColor.blue.cgColor
        trackLayer.slider = self
        layer.addSublayer(trackLayer)
        
        thumbLayer.backgroundColor = UIColor.green.cgColor
        thumbLayer.slider = self
        layer.addSublayer(thumbLayer)
        updateLayerFrames()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateLayerFrames() {
        
        trackLayer.frame = bounds.insetBy(dx: 0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        
        let thumbLayerCenter = CGFloat(positionForValue(value: currentValue))
        thumbLayer.frame = CGRect(x: thumbLayerCenter - thumbWidth / 2, y: 0, width: thumbWidth, height: thumbWidth)
        thumbLayer.setNeedsDisplay()
    }
    
    func positionForValue(value: Double) -> Double {
        return Double(bounds.width - thumbWidth) * (value - mininumValue) / (maxnumValue - mininumValue) + Double(thumbWidth / 2)
    }
}

extension SNSlider {
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        previousLocation = touch.location(in: self)
        
        if thumbLayer.frame.contains(previousLocation) {
            thumbLayer.hightlighted = true
        }
        
        return thumbLayer.hightlighted
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        // 1. Determine by how much the user has dragged
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maxnumValue - mininumValue) * deltaLocation / Double(bounds.width - thumbWidth)
         
        previousLocation = location
         
        // 2. Update the values
        if thumbLayer.hightlighted {
            currentValue += deltaValue
            currentValue = boundValue(value: currentValue, toLowerValue: mininumValue, upperValue: maxnumValue)
        }
         
        // 3. Update the UI
        CATransaction.begin()
        CATransaction.setDisableActions(true)
         
        updateLayerFrames()
         
        CATransaction.commit()
        sendActions(for: .valueChanged)
        return true
    }
    
    // limit value scope
    func boundValue(value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        thumbLayer.hightlighted = false
    }
}

class SNSliderThumbLayer: CALayer {
    var hightlighted = false
    weak var slider: SNSlider?
}

class SNSliderTrackLayer: CALayer {
    weak var slider: SNSlider?
    
    override func draw(in ctx: CGContext) {
        
        if let slider = slider {
            
            let cornerRadius = bounds.height * slider.curvaceousness / 2.0
            let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            ctx.addPath(path.cgPath)
            
            ctx.setFillColor(slider.trackTintColor.cgColor)
            ctx.addPath(path.cgPath)
            ctx.fillPath()
            
            ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
            let upperValue = CGFloat(slider.positionForValue(value: slider.currentValue))
            let rect = CGRect(x: 0, y: 0, width: upperValue, height: bounds.height)
            ctx.fill(rect)
        }
    }
}
