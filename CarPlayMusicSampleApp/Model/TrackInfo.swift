//
//  TrackInfo.swift
//  CarPlayMusicSampleApp
//
//  Created by Polepalli, Venkatesh on 30/01/24.
//

import Foundation

struct TrackInfo :Equatable{
    let title: String
    let artist: String
    let artwork: String
    let url: String
    let duration: TimeInterval
    let id: Int
    
    var formattedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [ .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: duration) ?? "00:00"
    }
    
}

