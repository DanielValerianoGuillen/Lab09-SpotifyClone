//
//  Spotify+Image.swift
//  SpotifyCloneB
//
//  Created by MAC42 on 14/05/22.
//

import Foundation
import UIKit

class HelperImage {
    
    static func setImageFromUrl(url: String) -> UIImage? {
        return convertImageFromURL(url: url)
    }
    
    static func convertImageFromURL(url: String) -> UIImage? {
        let data = try? Data(contentsOf: HelperString.getURLFromString(url: url)!)
        
        if let imageData = data {
            return UIImage(data: imageData)
        }
        
        return nil
    }
    
}
