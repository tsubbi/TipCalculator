//
//  TipCalculatorView.swift
//  
//
//  Created by Jamie Chen on 2021-05-10.
//

import UIKit

class TipCalculatorView: UIView {

    var tipAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$0"
        label.font = UIFont.systemFont(ofSize: 50)
        label.textAlignment = .center
        return label
    }()
    var billAmountTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 2
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.keyboardType = .decimalPad
        tf.placeholder = "Please enter bill amount"
        tf.layer.cornerRadius = 8
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
        tf.leftViewMode = .always
        return tf
    }()
    var containerStackView: UIStackView = {
        let stackV = UIStackView()
        stackV.axis = .vertical
        stackV.alignment = .fill
        stackV.distribution = .fillProportionally
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.spacing = 20
        return stackV
    }()
    var tipPercentageTextField: UITextField?
    var adjustTipPercentageSlider: UISlider?
    var calculateTipButton: UIButton?
    var type: ViewType
    
    init(frame: CGRect, type: ViewType) {
        self.type = type
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(self.containerStackView)
        
        self.containerStackView.addArrangedSubview(self.tipAmountLabel)
        let billTitle = UILabel()
        billTitle.text = "Bill Amount"
        billTitle.textAlignment = .left
        billTitle.font = UIFont.boldSystemFont(ofSize: 20)
        self.containerStackView.addArrangedSubview(billTitle)
        self.containerStackView.addArrangedSubview(self.billAmountTextField)
        for subView in type.subViews {
            switch subView {
            case .adjustTipPercentatgeSlider:
                self.adjustTipPercentageSlider = {
                    let slider = UISlider()
                    slider.minimumValue = 0
                    slider.maximumValue = 100
                    slider.isContinuous = true
                    slider.value = 15
                    return slider
                }()
            case .calculateTipButton:
                self.calculateTipButton = {
                    let button = UIButton(type: .system)
                    button.setTitle("Calculate Tip", for: .normal)
                    button.translatesAutoresizingMaskIntoConstraints = false
                    button.heightAnchor.constraint(equalToConstant: 44).isActive = true
                    return button
                }()
            case .tipPercentageTextField:
                self.tipPercentageTextField = {
                    let tf = UITextField()
                    tf.layer.borderWidth = 2
                    tf.layer.borderColor = UIColor.lightGray.cgColor
                    tf.keyboardType = .decimalPad
                    tf.layer.cornerRadius = 8
                    tf.translatesAutoresizingMaskIntoConstraints = false
                    tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
                    tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
                    tf.leftViewMode = .always
                    return tf
                }()
            }
        }
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            self.containerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}
