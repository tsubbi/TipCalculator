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
        label.font = UIFont.systemFont(ofSize: 80)
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
    var tipPercentageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "0%"
        return label
    }()
    var containerStackView: UIStackView = {
        let stackV = UIStackView()
        stackV.axis = .vertical
        stackV.alignment = .fill
        stackV.distribution = .fill
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
                    slider.value = 0
                    return slider
                }()
                self.containerStackView.addArrangedSubview(self.adjustTipPercentageSlider!)
            case .calculateTipButton:
                self.calculateTipButton = {
                    let button = UIButton(type: .system)
                    button.setTitle("Calculate Tip", for: .normal)
                    button.translatesAutoresizingMaskIntoConstraints = false
                    button.heightAnchor.constraint(equalToConstant: 44).isActive = true
                    return button
                }()
                self.containerStackView.addArrangedSubview(self.calculateTipButton!)
            case .tipPercentageTextField:
                let percentageTitle = UILabel()
                percentageTitle.text = "Tip Percentage"
                percentageTitle.textAlignment = .left
                percentageTitle.font = UIFont.boldSystemFont(ofSize: 20)
                percentageTitle.layoutIfNeeded()
                self.containerStackView.addArrangedSubview(percentageTitle)
                self.tipPercentageTextField = {
                    let tf = UITextField()
                    tf.layer.borderWidth = 2
                    tf.layer.borderColor = UIColor.lightGray.cgColor
                    tf.keyboardType = .numberPad
                    tf.placeholder = "Please enter tip percentage"
                    tf.layer.cornerRadius = 8
                    tf.translatesAutoresizingMaskIntoConstraints = false
                    tf.heightAnchor.constraint(equalToConstant: 44).isActive = true
                    tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
                    tf.leftViewMode = .always
                    return tf
                }()
                self.containerStackView.addArrangedSubview(self.tipPercentageTextField!)
                self.containerStackView.addArrangedSubview(self.tipPercentageLabel)
            }
        }
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            self.containerStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            self.containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}
