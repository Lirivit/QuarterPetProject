//
//  WelcomeView.swift
//  QuarterPetProject
//
//  Created by Kirill Fokov on 27.09.2021.
//

import Foundation
import UIKit
import SnapKit

protocol WelcomeViewDelegate: AnyObject {
    func didTapNextButton()
}

/// Welcome user view
class WelcomeView: UIView {
    /// Welcome view delegate
    weak var delegate: WelcomeViewDelegate?
    
    /// Label with welcoming text
    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to my pet project, where you can see and test my knowladge in ARKit and CoreML!"
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    /// Welcome image view
    private var welcomeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "welcomeImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    /// Next button
    private var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    /// Next button action
    @objc func didTapNextButton(sender: UIButton!) {
        self.delegate?.didTapNextButton()
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
        addSubview(welcomeLabel)
        addSubview(welcomeImageView)
        addSubview(nextButton)
       
        //Constraints
        welcomeLabel.snp.makeConstraints { make in
            make.topMargin.equalTo(self).offset(30)
            make.leading.equalTo(self).offset(10)
            make.trailing.equalTo(self).offset(-10)
        }
        
        welcomeImageView.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(10)
            make.centerX.equalTo(self)
            make.height.equalTo(250)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottomMargin.equalTo(self).offset(-10)
            make.height.equalTo(40)
        }
    }
}
