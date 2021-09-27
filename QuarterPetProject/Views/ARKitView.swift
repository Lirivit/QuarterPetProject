//
//  ARKitView.swift
//  QuarterPetProject
//
//  Created by Kirill Fokov on 27.09.2021.
//

import Foundation
import RealityKit
import UIKit
import SnapKit

protocol ARKitViewDelegate: AnyObject {
    func didTapPlayButton()
    func didTapBackButton()
}
class ARKitView: UIView {
    /// AR Kit view delegate
    weak var delegate: ARKitViewDelegate?
    /// AR Kit view
    var arView: ARView = {
        let view = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        return view
    }()
    /// Back button
    private var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow"), for: .normal)
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    /// Play button
    private var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        return button
    }()
    /// Loading indicator
    var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
       view.color = .white
       view.hidesWhenStopped = true
       return view
    }()
    /// Init
    init() {
        super.init(frame: CGRect.zero)

        // Setup subviews
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// Play button action
    @objc func didTapPlayButton(sender: UIButton!) {
        self.delegate?.didTapPlayButton()
    }
    /// Back button action
    @objc func didTapBackButton(sender: UIButton!) {
        self.delegate?.didTapBackButton()
    }
    /// Setup
    func setup() {
        addSubview(arView)
        arView.addSubview(backButton)
        arView.addSubview(playButton)
        arView.addSubview(loadingIndicator)
        
        arView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(arView)
            make.centerY.equalTo(arView)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self).offset(15)
            make.leading.equalTo(self).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalTo(arView)
            make.bottom.equalTo(arView).offset(-10)
        }
    }
}
