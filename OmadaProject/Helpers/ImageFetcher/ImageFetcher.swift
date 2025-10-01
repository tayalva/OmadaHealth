//
//  ImageFetcher.swift
//  OmadaProject
//
//  Created by Taylor Smith on 10/1/25.
//

import SwiftUI
import Kingfisher

struct ImageFetcher: View {
    let url: URL?
    var contentMode: SwiftUI.ContentMode = .fit
    
    var placeholder: AnyView = AnyView(
        Image(systemName: "popcorn")
            .resizable()
            .scaledToFit()
    )
    
    var body: some View {
        KFImage(url)
            .placeholder { placeholder }
            .retry(maxCount: 2, interval: .seconds(2))
            .resizable()
            .aspectRatio(contentMode: contentMode)
    }
}
