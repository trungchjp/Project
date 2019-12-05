//
//  QRScanViewController.swift
//  Project
//
//  Created by Nguyễn Trung on 11/29/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit
import AVFoundation

class QRScanViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let alertController = UIAlertController(title: "Bạn đã điểm danh thành công", message: "", preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
//            UIAlertAction in
//            self.dimiss()
//        }
//        alertController.addAction(okAction)
//        self.present(alertController, animated: true, completion: nil)
        
        messageLabel.text = "No QR code is detected"
        // Move the message label and top bar to the front
        self.view.bringSubviewToFront(messageLabel)
//        messageLabel.isUserInteractionEnabled = true

        navigationItem.title = "Scan"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(dimiss))
        
         let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)

         guard let captureDevice = deviceDiscoverySession.devices.first else {
             print("Failed to get the camera device")
             return
         }

         do {
             let input = try AVCaptureDeviceInput(device: captureDevice)
             captureSession.addInput(input)

         } catch {
             print(error)
             return
         }

         let captureMetadataOutput = AVCaptureMetadataOutput()
         captureSession.addOutput(captureMetadataOutput)

         captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
         captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]

         videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
         videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
         videoPreviewLayer?.frame = view.layer.bounds
         view.layer.addSublayer(videoPreviewLayer!)
            
         captureSession.startRunning()
         
         qrCodeFrameView = UIView()
         
         if let qrCodeFrameView = qrCodeFrameView {
             qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
             qrCodeFrameView.layer.borderWidth = 2
             view.addSubview(qrCodeFrameView)
//             view.bringSubviewToFront(qrCodeFrameView)
         }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            qrCodeFrameView!.frame = CGRect.zero
            messageLabel.text = "No QR code is detected"
            print("No QR code is detected")
            return
        }

        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView.frame = barCodeObject!.bounds

            if metadataObj.stringValue != nil {
                messageLabel.text = metadataObj.stringValue
                let a = messageLabel.text
                print(a!)
            }
            
        }
    }

    @objc func dimiss(){
        dismiss(animated: true, completion: nil)
    }

}

extension QRScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    
}
