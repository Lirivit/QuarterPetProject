//
//  ChooseARModelView.swift
//  QuarterPetProject
//
//  Created by Kirill Fokov on 27.09.2021.
//

import Foundation
import UIKit
import SnapKit

protocol ChooseARModelViewDelegate: AnyObject {
    func didTapRobotModelButton()
    func didTapGramophoneButton()
    func didTapDrummerButton()
    func didTapBackButton()
}

class ChooseARModelView: UIView {
    /// AR models view delegate
    weak var delegate: ChooseARModelViewDelegate?
    /// Background view
    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = false
        return view
    }()
    /// Back button
    private var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowleft"), for: .normal)
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    /// Header label
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose one of the models below."
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    /// Stack views wrapper
    private var stackViewWrapper: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    /// Top images view wrapper
    private var topImagesWrapper: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    /// Bottom images view wrapper
    private var bottomImagesWrapper: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    /// AR robot model image view
    private var robotImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "vintagerobot2k"), for: .normal)
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.gray.cgColor.copy(alpha: 0.5)
        button.addTarget(self, action: #selector(robotButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    /// AR dummer model image view
    private var drummerImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "drummertoy"), for: .normal)
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.gray.cgColor.copy(alpha: 0.5)
        button.addTarget(self, action: #selector(drummerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    /// AR Orphane image view
    private var orphaneImageView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "gramophone"), for: .normal)
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.gray.cgColor.copy(alpha: 0.5)
        button.addTarget(self, action: #selector(gromophoneButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    /// Robot image action
    @objc func robotButtonTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.delegate?.didTapRobotModelButton()
    }
    /// Drummer image action
    @objc func drummerButtonTapped(sender: UIButton!) {
        self.delegate?.didTapDrummerButton()
    }
    /// Gromophone image action
    @objc func gromophoneButtonTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.delegate?.didTapGramophoneButton()
    }
    /// Back button action
    @objc func didTapBackButton(sender: UIButton!) {
        self.delegate?.didTapBackButton()
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
    /// Setup constraints function
    func setup() {
        // Background
        backgroundColor = .red
        // Subviews
        addSubview(backgroundView)
        backgroundView.addSubview(backButton)
        backgroundView.addSubview(headerLabel)
        backgroundView.addSubview(stackViewWrapper)
        stackViewWrapper.addArrangedSubview(topImagesWrapper)
        stackViewWrapper.addArrangedSubview(bottomImagesWrapper)
        topImagesWrapper.addArrangedSubview(robotImageView)
        topImagesWrapper.addArrangedSubview(drummerImageView)
        bottomImagesWrapper.addSubview(orphaneImageView)
        // Constraints
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(backgroundView).offset(30)
            make.leading.equalTo(backgroundView).offset(15)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundView).offset(30)
            make.leading.equalTo(backButton.snp.trailing).offset(10)
        }
        
        stackViewWrapper.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.leading.equalTo(backgroundView).offset(15)
            make.trailing.equalTo(backgroundView).offset(-15)
            make.bottom.equalTo(backgroundView).offset(-15)
        }
        
        orphaneImageView.snp.makeConstraints { make in
            make.height.equalTo(bottomImagesWrapper)
            make.width.equalTo(robotImageView.snp.width)
            make.centerX.equalTo(bottomImagesWrapper)
            make.centerY.equalTo(bottomImagesWrapper)
        }
    }
}
