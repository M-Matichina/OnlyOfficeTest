//
//  FileDetailViewController.swift
//  OnlyOfficeTest
//
//  Created by Мария Матичина on 10/13/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import UIKit
import PDFKit

class FileDetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet var pdfView: PDFView!

    
    // MARK: - Properties
    
    var fileURL: String?
    var name: String?
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = name

        if let path = fileURL {
            if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
                pdfView.displayMode = .singlePageContinuous
                pdfView.autoScales = true
                pdfView.displayDirection = .vertical
                pdfView.document = pdfDocument
            }
        }
    }
}
