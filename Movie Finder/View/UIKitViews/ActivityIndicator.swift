//
//  ActivityIndicator.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 20/01/23.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable{
    func makeUIView(context: Context) -> some UIView {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
