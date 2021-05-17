//
//  ViewController.swift
//  Slider
//
//  Created by 楠 on 2021/5/14.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let slider = SNSlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(slider)
        slider.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }

        slider.addTarget(self, action: #selector(rangeSliderValueChanged), for: .valueChanged)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        

    }
    
    @objc func rangeSliderValueChanged(rangeSlider: SNSlider) {
        print("Range slider value changed: (\(rangeSlider.currentValue) \(rangeSlider.maxnumValue))")
    }

}

