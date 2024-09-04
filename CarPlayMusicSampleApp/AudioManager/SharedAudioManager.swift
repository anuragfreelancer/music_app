//
//  AudioManager.swift
//  CarPlayMusicSampleApp
//
//  Created by Polepalli, Venkatesh on 30/01/24.
//


import Foundation
import MediaPlayer

protocol MusicControlsDelegate{
    func playCurrentSong()
    func pauseCurrentSong()
    func nextSong(song: TrackInfo)
    func previousSong(song: TrackInfo)
}

protocol CommunicationBetweenCarplayToMobileDelegate{
    func communicateFromCarPlayToMobile(selectedSong:TrackInfo)
}

protocol CommunicationBetweenMobileToCarPlayDelegate{
    func communicateFromMobileToCarPlay(selectedSong: TrackInfo)
}

protocol UpdateSongInfoFromMobileToCarPlayDelegate{
    func changeSongInfo(selectedSong:TrackInfo)
}

class AudioManager {
    
    var musicControlsDelegate: MusicControlsDelegate?
    var carplayToMobileDelegate: CommunicationBetweenCarplayToMobileDelegate?
    var mobileToCarplayDelegate: CommunicationBetweenMobileToCarPlayDelegate?
    var updateSongInfoDelegate: UpdateSongInfoFromMobileToCarPlayDelegate?
    var nowPlayingDetails: [String: Any] = [:]
    var playerManager = PlayerManager(player:AVPlayer())
    
    static let shared = AudioManager()
    
    ///ProgressBar Details in Carplay
    func nowPlayingProgressBarDetailsInCarPlay() {
        self.nowPlayingDetails[MPNowPlayingInfoPropertyPlaybackRate] = self.playerManager.getPlayingRate
        self.nowPlayingDetails[MPMediaItemPropertyPlaybackDuration] = self.playerManager.getDurationInSeconds
        self.nowPlayingDetails[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.playerManager.getCurrentTimeInSeconds
        MPNowPlayingInfoCenter.default().playbackState = self.playerManager.isPlaying ? .playing : .paused
        MPNowPlayingInfoCenter.default().nowPlayingInfo = self.nowPlayingDetails
    }
    
   ///Song Details in CarPlay
    ///if change require remove if and dispatchqueue
    func showSongDetailsInCarplay(song: TrackInfo) {
        DispatchQueue.main.async {  
            if (!self.nowPlayingDetails.isEmpty){
                self.nowPlayingDetails.removeAll()
            }
            self.nowPlayingDetails[MPMediaItemPropertyTitle] = song.title
            self.nowPlayingDetails[MPMediaItemPropertyArtist] = song.artist
            MPNowPlayingInfoCenter.default().nowPlayingInfo = self.nowPlayingDetails
            self.nowPlayingProgressBarDetailsInCarPlay()
        }
        
    }
    
}

