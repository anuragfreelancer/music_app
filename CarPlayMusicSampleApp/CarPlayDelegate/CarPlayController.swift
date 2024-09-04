//
//  CarPlayController.swift
//  CarPlayMusicSampleApp
//
//  Created by Polepalli, Venkatesh on 30/01/24.
//

import Foundation
import CarPlay
import MediaPlayer

class CarPlayController {
    var interfaceController: CPInterfaceController?
    let nowPlayingTemplate = CPNowPlayingTemplate.shared
    let commandCenter = MPRemoteCommandCenter.shared()
    let carPlayMusicViewModel = MusicViewModel()
    
    func setRootTemplate() {
        updateListTemplate()
        AudioManager.shared.mobileToCarplayDelegate = self
        AudioManager.shared.updateSongInfoDelegate = self
    }
    
    ///updating the car play details
    private func updateCarPlayDetails(song: TrackInfo) {
        carPlayMusicViewModel.songInfo = song
        AudioManager.shared.showSongDetailsInCarplay(song: song)
        updateForwardandBackwardButtonStates()
    }
    
    // carplay Music player Details NowPlayingTemplate
    private func updateMusicTemplate(song:TrackInfo) {
        updateCarPlayDetails(song: song)
        AudioManager.shared.playerManager.setPlayer(url: song.url)
        
#if targetEnvironment(simulator)
        UIApplication.shared.endReceivingRemoteControlEvents()
        UIApplication.shared.beginReceivingRemoteControlEvents()
#endif
        
        if self.interfaceController?.topTemplate == nowPlayingTemplate {
            updateCarPlayDetails(song: song)
        } else {
            self.interfaceController?.pushTemplate(self.nowPlayingTemplate, animated: true, completion: nil)
        }
    }
    
    //updating List Template
    func updateListTemplate() {
        let items = carPlayMusicViewModel.songs.map {song in
            let listItem = CPListItem(text: song.title, detailText: song.artist)
            listItem.handler = { item,completion in
                AudioManager.shared.carplayToMobileDelegate?.communicateFromCarPlayToMobile(selectedSong: song)
                self.updateMusicTemplate(song: song)
                completion()
            }
            return listItem
        }
        let section = CPListSection(items: items)
        let template = CPListTemplate(title: Constants.TabTemplate.title, sections: [section])
        template.tabImage = UIImage(systemName: Constants.Images.radio)
        template.tabTitle = Constants.TabTemplate.title
        let tabBarTemplate = CPTabBarTemplate(templates: [template])
        interfaceController?.setRootTemplate(tabBarTemplate, animated: true, completion: nil)
    }
}

//MARK: -  Mobile to CarPlay Communication  Delegate
extension CarPlayController: CommunicationBetweenMobileToCarPlayDelegate,UpdateSongInfoFromMobileToCarPlayDelegate {//U
    func changeSongInfo(selectedSong: TrackInfo) {
        carPlayMusicViewModel.songInfo = selectedSong
        updateForwardandBackwardButtonStates()
    }
    
    func communicateFromMobileToCarPlay(selectedSong: TrackInfo) {
        self.updateMusicTemplate(song: selectedSong)
    }
}


//MARK: -  CarPlay Music Controls
extension CarPlayController {
    
    //Music Controls in now playing Template
    func setupRemoteCommandCenterTargets() {
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget {event in
            AudioManager.shared.playerManager.playSong()
            AudioManager.shared.musicControlsDelegate?.playCurrentSong()
            return .success
        }
        
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget {event in
            AudioManager.shared.playerManager.stopSong()
            AudioManager.shared.musicControlsDelegate?.pauseCurrentSong()
            return .success
        }
        
        commandCenter.nextTrackCommand.isEnabled = true
        commandCenter.nextTrackCommand.addTarget { [self] event in
            executeNextTrackCommand()
            return .success
        }
        
        commandCenter.previousTrackCommand.isEnabled = true
        commandCenter.previousTrackCommand.addTarget { [self] event in
            executePreviousTrackCommand()
            return .success
        }
    }
    
    //change to next song
    private func upComingSongInfo(song:TrackInfo) {
        AudioManager.shared.showSongDetailsInCarplay(song: song)
        AudioManager.shared.playerManager.replaceCurrentSong(songUrl : song.url)
        updateForwardandBackwardButtonStates()
    }
    
    ///playing next song
    private func executeNextTrackCommand() {
        carPlayMusicViewModel.playNextSong { song in
            self.upComingSongInfo(song: song)
            AudioManager.shared.playerManager.playSong()
            AudioManager.shared.musicControlsDelegate?.nextSong(song: song)
           
        }
    }
    
    ///playing previous song
    private func executePreviousTrackCommand() {
        carPlayMusicViewModel.playPreviousSong { song in
            self.upComingSongInfo(song: song)
            AudioManager.shared.playerManager.playSong()
            AudioManager.shared.musicControlsDelegate?.previousSong(song: song)
            
        }
    }
    
    //check button enabled status for forward and backward button
    private func updateForwardandBackwardButtonStates() {
        commandCenter.nextTrackCommand.isEnabled = carPlayMusicViewModel.isForwardButtonEnabled
        commandCenter.previousTrackCommand.isEnabled = carPlayMusicViewModel.isBackButtonEnabled
    }
    
}
