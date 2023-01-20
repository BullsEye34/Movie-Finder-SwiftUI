//
//  SafariView.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 20/01/23.
//

import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable{
    let url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let safariVC = SFSafariViewController(url: self.url)
        return safariVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
