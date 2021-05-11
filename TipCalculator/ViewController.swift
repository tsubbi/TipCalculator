//
//  ViewController.swift
//  TipCalculator
//
//  Created by Jamie Chen on 2021-05-09.
//

import UIKit

class ViewController: UIViewController {
    private(set) var type: ViewType
    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let contentView = TipCalculatorView(frame: .zero, type: .tipTextField)
    
    init(type: ViewType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        layoutView()
    }
    
    private func setupView() {
        self.view.addSubview(self.contentScrollView)
        self.contentScrollView.addSubview(self.contentView)
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

    @objc private func calculateTip() {
        print("calculate")
    }
}

