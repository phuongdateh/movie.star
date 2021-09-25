//
//  MovieConfigure.swift
//  core
//
//  Created by Doan Duy Phuong on 25/09/2021.
//

import Foundation

struct MovieConfigure: Decodable {
    let apikey: String
    let homeConfig: [HomeConfigure]
    let isEnableAppOpenAds: Bool
    let isEnableInterstitialAds: Bool
    let isEnableNativeAds: Bool
    let isEnableSearchMovie: Bool
    let isEnableBannerAds: Bool
    
    enum CodingKeys: String, CodingKey {
        case apikey
        case homeConfig = "home_sections"
        case isEnableAppOpenAds
        case isEnableInterstitialAds
        case isEnableNativeAds
        case isEnableSearchMovie
        case isEnableBannerAds
    }
}
