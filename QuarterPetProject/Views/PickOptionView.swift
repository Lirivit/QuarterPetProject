//
//  PickOptionView.swift
//  QuarterPetProject
//
//  Created by Kirill Fokov on 27.09.2021.
//

import Foundation
import UIKit
import SnapKit

protocol PickOptionViewDelegate: AnyObject {
    func didTapARButton()
    func didTapMLButton()
}

class PickOptionView: UIView {
    /// Pick option view delegate
    weak var delegate: PickOptionViewDelegate?
    /// Label with choose text
    private var chooseLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose one of the options below"
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    /// Down arrow image view
    private var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "downArrow")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    /// Custom tool bar with buttons
    private var buttonsWrapper: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    /// Tool bar AR button
    private var arButton: UIButton = {
        let button = UIButton()
        button.setTitle("AR", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(didTapARButton), for: .touchUpInside)
        return button
    }()
    /// Tool bar ML button
    private var mlButton: UIButton = {
        let button = UIButton()
        button.setTitle("ML", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(didTapMLButton), for: .touchUpInside)
        return button
    }()
    /// AR button action
    @objc func didTapARButton(sender: UIButton!) {
        self.delegate?.didTapARButton()
    }
    /// ML button action
    @objc func didTapMLButton(sender: UIButton!) {
        self.delegate?.didTapMLButton()
    }
    /// Init
    init() {
        super.init(frame: CGRect.zero)

        // Setup subviews
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        // Background
        backgroundColor = .white
        // Subviews
        addSubview(chooseLabel)
        addSubview(arrowImageView)
        addSubview(buttonsWrapper)
        buttonsWrapper.addArrangedSubview(arButton)
        buttonsWrapper.addArrangedSubview(mlButton)
        //Constraints
        
        chooseLabel.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.bottom.equalTo(arrowImageView.snp.top).offset(-15)
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(buttonsWrapper).offset(-20)
            make.height.equalTo(200)
        }
        
        buttonsWrapper.snp.makeConstraints { make in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottomMargin.equalTo(self).offset(-15)
            make.height.equalTo(40)
        }
    }
}
