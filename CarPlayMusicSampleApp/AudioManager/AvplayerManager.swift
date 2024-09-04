//
//  AvplayerManager.swift
//  CarPlayMusicSampleApp
//
//  Created by Polepalli, Venkatesh on 30/01/24.
//

import Foundation
import AVFoundation

enum PlayerItemError: Error {
    case invalidURL
}


class PlayerManager {
    private var player: AVPlayer!
    
    var isPlaying: Bool {
        return self.player.rate != 0
    }
    var getDuration: CMTime {
        return self.player.currentItem?.asset.duration ?? CMTime.zero
    }
    var getCurrentTime: CMTime {
        return self.player.currentTime()
    }
    var getPlayingRate: Float {
        return self.player.rate
    }
    var getDurationInSeconds: Double {
        let duration = getDuration
        return duration.seconds
    }
    var getCurrentTimeInSeconds: Double {
        let currentTime = getCurrentTime
        return currentTime.seconds
    }
    
    init(player: AVPlayer!) {
        self.player = player
    }
    
   private func instantiatePlayerItem(url: String) throws -> AVPlayerItem {
       guard let url = URL(string: url) else {
           throw PlayerItemError.invalidURL
           }
           let playerItem = AVPlayerItem(url: url)
           return playerItem
    }
    
    func setPlayer(url: String) {
        if (self.player != nil) {
            do {
                let playerItem = try instantiatePlayerItem(url: url)
                self.player = AVPlayer(playerItem: playerItem)
                self.player.rate = 1.0
            }
            catch {
                print("invalid url")
            }
        }
    }
    
    func playSong()  {
        #if DEBUG
        print("Player SongPlayed")
        #endif
        self.player.play()
    }
    
    func stopSong() {
        #if DEBUG
        print("Player song Stopped")
        #endif
        self.player.pause()
    }
    
    func replaceCurrentSong(songUrl url: String) {
        do{
            let replacePlayerItemWithNewSongUrl = try instantiatePlayerItem(url: url)
            self.player.replaceCurrentItem(with: replacePlayerItemWithNewSongUrl)
        }
        catch {
            print("invalid url")
        }
    }
    
    func resumeSongAt(value: Double) {
        self.player.seek(to: CMTime(seconds: value, preferredTimescale: 1))
    }

}
