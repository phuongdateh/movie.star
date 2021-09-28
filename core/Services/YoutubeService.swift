//
//  YoutubeService.swift
//  core
//
//  Created by phuong.doand on 14/09/2021.
//

import Foundation
import XCDYouTubeKit

final class YoutubeService: NSObject {
    static let shared = YoutubeService()
    
    func getVideo(by videoIdentifier: String, completion: @escaping ((YoutubeVideo?) -> ())) {
        XCDYouTubeClient.default().getVideoWithIdentifier(videoIdentifier) { video, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            if let video = video {
                completion(YoutubeVideo(video: video))
            } else {
                completion(nil)
            }
        }
    }
}
