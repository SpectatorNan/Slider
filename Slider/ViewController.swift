//
//  ViewController.swift
//  Slider
//
//  Created by 楠 on 2021/5/14.
//

import UIKit
import SnapKit
//https://robinchinblog.wordpress.com/2017/05/01/custom-slider-%E8%87%AA%E8%A8%82%E6%8B%96%E6%8B%89bar/
class ViewController: UIViewController {

//    let rangeSlider = RangeSlider()
    let slider = SNSlider()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        slider.backgroundColor = .red
        view.addSubview(slider)
        slider.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
//        view.addSubview(rangeSlider)
//
        slider.addTarget(self, action: #selector(rangeSliderValueChanged), for: .valueChanged)
//
//        let delayInSeconds = 4.0
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
//            self.rangeSlider.trackHighlightTintColor = UIColor.red
//            self.rangeSlider.curvaceousness = 0.0
//        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        
//        let margin: CGFloat = 20.0
//        let width = view.bounds.width - 2.0 * margin
//        rangeSlider.frame = CGRect(x: margin, y: margin + view.safeAreaInsets.top, width: width, height: 31.0)
    }
    
    @objc func rangeSliderValueChanged(rangeSlider: SNSlider) {
        print("Range slider value changed: (\(rangeSlider.currentValue) \(rangeSlider.maxnumValue))")
    }

}

