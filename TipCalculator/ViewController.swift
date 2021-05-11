//
//  ViewController.swift
//  TipCalculator
//
//  Created by Jamie Chen on 2021-05-09.
//

import UIKit

class ViewController: UIViewController {
    private(set) var type: ViewType
    let contentView: TipCalculatorView
    var tipPercent: Int = 0
    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    init(type: ViewType) {
        self.type = type
        self.contentView = TipCalculatorView(frame: .zero, type: type)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        tap.numberOfTapsRequired = 1
        self.contentView.addGestureRecognizer(tap)
        setupView()
        layoutView()
        
    }
    
    private func setupView() {
        self.view.addSubview(self.contentScrollView)
        self.contentScrollView.addSubview(self.contentView)
        
        if let calculateTipBtn = self.contentView.calculateTipButton {
            calculateTipBtn.addTarget(self, action: #selector(self.calculateTip(_:)), for: .touchUpInside)
        }
        
        if let percentageTF = self.contentView.tipPercentageTextField, self.type == .tipSlider {
            percentageTF.addTarget(self, action: #selector(self.calculateTip(_:)), for: .editingChanged)
        }
        
        if let slider = self.contentView.adjustTipPercentageSlider {
            slider.addTarget(self, action: #selector(self.calculateTip(_:)), for: .valueChanged)
        }
    }
    
    private func layoutView() {
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            self.contentScrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.contentScrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.contentScrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.contentScrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.contentScrollView.contentLayoutGuide.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.contentScrollView.contentLayoutGuide.trailingAnchor),
            self.contentView.topAnchor.constraint(equalTo: self.contentScrollView.contentLayoutGuide.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.contentScrollView.contentLayoutGuide.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.contentScrollView.widthAnchor)
        ])
    }
    
    @objc private func closeKeyboard() {
        self.contentView.containerStackView.arrangedSubviews.filter({ $0 is UITextField }).forEach {
            ($0 as! UITextField).resignFirstResponder()
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        self.contentScrollView.contentInset = contentInsets
        self.contentScrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardDidShow(notification: Notification) {
        guard let info = notification.userInfo,
              let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        self.contentScrollView.contentInset = contentInsets
        self.contentScrollView.scrollIndicatorInsets = contentInsets
    }

    @objc private func calculateTip(_ sender: Any) {
        guard let bill = self.contentView.billAmountTextField.text, !bill.isEmpty else {
            let alert = UIAlertController(title: "Bill is empty", message: "Please enter amount for bill", preferredStyle: .alert)
            let action = UIAlertAction(title: "Understood", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if sender is UITextField || sender is UISlider {
            updatePercentage(sender)
        } else {
            self.tipPercent = Int(self.contentView.tipPercentageTextField?.text ?? "") ?? 0
            self.contentView.tipPercentageLabel.text = "\(self.tipPercent)%"
        }
        
        let tip = (Double(self.tipPercent)/100) * Double((bill as NSString).doubleValue)
        
        self.contentView.tipAmountLabel.text = "$\(String(format: "%.2f", tip))"
    }
    
    private func updatePercentage(_ sender: Any) {
        if let tf = sender as? UITextField, let value = tf.text {
            let percentage = (value as NSString).floatValue
            self.contentView.tipPercentageLabel.text = "\(Int(percentage))%"
            self.contentView.adjustTipPercentageSlider?.value = percentage
            self.tipPercent = Int(percentage)
        } else if let slider = sender as? UISlider {
            self.contentView.tipPercentageLabel.text = "\(Int(slider.value))%"
            self.contentView.tipPercentageTextField?.text = "\(Int(slider.value))"
            self.tipPercent = Int(slider.value)
        }
    }
}

