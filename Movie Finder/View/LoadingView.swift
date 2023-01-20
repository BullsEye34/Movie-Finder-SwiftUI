//
//  LoadingView.swift
//  Movie Finder
//
//  Created by P Vamshi Prasad on 20/01/23.
//

import SwiftUI

struct LoadingView: View {
    let isLoading: Bool
    let error: NSError?
    let retryAction: (()->())?
    
    var body: some View {
        Group{
            if isLoading{
                Spacer()
                ActivityIndicator()
                Spacer()
            } else if error != nil{
                HStack{
                    Spacer()
                    VStack{
                        Text(error!.localizedDescription).font(.headline)
                        if self.retryAction != nil{
                            Button(action: self.retryAction!) {
                                Text("Retry")
                            }
                            .foregroundColor(Color(UIColor.systemBlue))
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: true, error: nil, retryAction: nil)
    }
}
