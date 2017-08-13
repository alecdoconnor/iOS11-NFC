//
//  ViewController.swift
//  testingNFC
//
//  Created by Alec O'Connor on 6/6/17.
//  Copyright © 2017 Alec O'Connor. All rights reserved.
//

import UIKit
import CoreNFC

class ViewController: UIViewController, NFCNDEFReaderSessionDelegate {
    
    @IBOutlet weak var nfcOutput: UILabel!
    var session: NFCNDEFReaderSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let output = "Enabling...\n\n"
        nfcOutput.text = output
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("Invalidated NDEF")
        DispatchQueue.main.async {
            self.nfcOutput.text = "\(error)"
        }
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print("Detected NDEF")
        var payload = ""
        for message in messages {
            for record in message.records {
                print(record.identifier)
                print(record.payload)
                print(record.type)
                print(record.typeNameFormat)
                
                payload += "\(record.identifier)\n"
                payload += "\(record.payload)\n"
                payload += "\(record.type)\n"
                payload += "\(record.typeNameFormat)\n"
                
                
                let output = "\(nfcOutput.text ?? "")\(payload)"
                
                nfcOutput.text = output
            }
        }
    }


}

