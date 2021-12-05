//
//  MeView.swift
//  Hot Prospects
//
//  Created by Yash Poojary on 03/12/21.
//

import SwiftUI
import CoreImage.CIFilterBuiltins


struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "you@yoursite.com"

    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: $name)
                    .padding(.horizontal)
                    .font(.title)
                    .textContentType(.name)
                TextField("Email", text: $emailAddress)
                    .padding([.horizontal, .bottom])
                    .font(.title)
                    .textContentType(.emailAddress)
                
                Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    
                
                Spacer()
            }
      
            .navigationTitle("Your Code")
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
