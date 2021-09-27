//
//  MLView.swift
//  QuarterPetProject
//
//  Created by Kirill Fokov on 27.09.2021.
//

import Foundation
import UIKit
import AVKit
import Vision
import SnapKit

protocol MLViewDelegate: AnyObject {
    func didTapBackButton()
}
class MLView: UIView {
    /// ML View delegate
    weak var delegate: MLViewDelegate?
    /// Back button
    private var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow"), for: .normal)
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    /// Ml object label
    private var objectLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    /// ML video data output
    private lazy var videoDataOutput: AVCaptureVideoDataOutput = {
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        return output
    }()
    /// ML video preview layer
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
            let layer = AVCaptureVideoPreviewLayer(session: session)
            layer.videoGravity = .resizeAspect
            return layer
    }()
    /// ML capture device
    private let captureDevice: AVCaptureDevice? = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                                          for: .video,
                                                                          position: .back)
    /// ML session
    private lazy var session: AVCaptureSession = {
            let session = AVCaptureSession()
            session.sessionPreset = .photo
            return session
    }()
    /// Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    /// Func to start session
    private func beginSession() {
        do {
            guard let captureDevice = captureDevice else {
                fatalError("Camera doesn't work on the simulator! You have to test this on an actual device!")
            }
                
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
                
            if session.canAddInput(deviceInput) {
                session.addInput(deviceInput)
            }

            if session.canAddOutput(videoDataOutput) {
                session.addOutput(videoDataOutput)
            }
                
            layer.masksToBounds = true
            layer.addSublayer(previewLayer)
            previewLayer.frame = bounds
            session.startRunning()
                
        } catch let error {
            debugPrint("\(self.self): \(#function) line: \(#line).  \(error.localizedDescription)")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer.frame = bounds
    }
    
    func setup() {
        contentMode = .scaleAspectFit
        beginSession()
        // Subview
        addSubview(backButton)
        addSubview(objectLabel)
        // Constraints
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self).offset(15)
            make.leading.equalTo(self).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        objectLabel.snp.makeConstraints { make in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(self).offset(-10)
        }
    }
    
    @objc func didTapBackButton(sender: UIButton!) {
        self.delegate?.didTapBackButton()
    }
}

extension MLView: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        guard let model = try?  VNCoreMLModel(for: Resnet50().model) else {
            return
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            
            guard let results = request.results as? [VNClassificationObservation] else {
                return
            }
            
            guard let firstObjectObserved = results.first else {
                return
            }
            
            DispatchQueue.main.async {
                self.objectLabel.text = firstObjectObserved.identifier
            }
            
            print(firstObjectObserved.identifier, firstObjectObserved.confidence)
        }
        
       try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
}
