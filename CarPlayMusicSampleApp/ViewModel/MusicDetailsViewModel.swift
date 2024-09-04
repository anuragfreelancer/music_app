//
//  MusicDetailsViewModel.swift
//  CarPlayMusicSampleApp
//
//  Created by Polepalli, Venkatesh on 30/01/24.
//

import Foundation
import CoreMedia
import FirebaseFirestoreInternal


class MusicViewModel {
    
//    var songInfo: TrackInfo?
//   // private(set) var songs: [TrackInfo] = [] // Use private(set) to restrict external modification
//    
//        var getSongsData = songsData()
//    
//        var songs:[TrackInfo] {
//            return getSongsData.getSongs()
//        }
    
    var songInfo: TrackInfo?
        private var _songs: [TrackInfo] = []
        
        var songs: [TrackInfo] {
            return _songs
        }
    
    var isBackButtonEnabled: Bool {
        songInfo?.id != songs.first?.id
    }
    
    var isForwardButtonEnabled: Bool {
        songInfo?.id != songs.last?.id
    }
    
    var getCurrentValueOfSlider: Double {
        let currentTiming = AudioManager.shared.playerManager.getCurrentTime
        let currentTimeInSeconds = CMTimeGetSeconds(currentTiming)
        return currentTimeInSeconds
    }
    
    func getSliderMaxValue() -> Float {
        Float(CMTimeGetSeconds(AudioManager.shared.playerManager.getDuration))
    }
    
    func playPreviousSong(previousSong: (TrackInfo) -> ()) {
        guard let currentSong = songInfo,let currentIndex = songs.firstIndex(where: { $0.id == currentSong.id }), currentIndex > 0  else {
            return
        }
        let previousIndex = currentIndex - 1
        updateSongInfo(index: previousIndex, changeCurrentSong: previousSong)
    }
    
    func playNextSong(nextSong: (TrackInfo) -> ()) {
        guard let currentSong = songInfo,let currentIndex = songs.firstIndex(where: { $0.id == currentSong.id }),currentIndex < songs.count - 1 else {
            return updateSongInfo(index: 0, changeCurrentSong: nextSong)
        }
        let nextIndex = currentIndex + 1
        updateSongInfo(index: nextIndex, changeCurrentSong: nextSong)
    }
    
    private func updateSongInfo(index: Int, changeCurrentSong: (TrackInfo) -> ()) {
        guard index >= 0 && index < songs.count else {
            return
        }
        songInfo = songs[index]
        if let songInfo = songInfo {
            changeCurrentSong(songInfo)
        }
    }
    
    
    func formattedCurrentTimeString(time: TimeInterval) -> String {
        guard time >= 0 else {
            return "Invalid time"
        }
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func fetchSongsFromFirestore(completion: @escaping () -> Void) {
        let db = Firestore.firestore()
        db.collection("songs").getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching songs from Firestore: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No songs found")
                return
            }
            
            // Print the raw documents for debugging
            print("Fetched documents: \(documents)")
            
            self?._songs = documents.compactMap { doc -> TrackInfo? in
                let data = doc.data()
                print("Document data: \(data)") // Print each document's data
                
                // Read id as Int directly
                guard
                    let title = data["title"] as? String,
                    let artist = data["artist"] as? String,
                    let artwork = data["artwork"] as? String,
                    let url = data["url"] as? String,
                    let duration = data["duration"] as? Double,
                    let id = data["id"] as? Int else { // Read id as Int
                        print("Failed to parse document data: \(data)")
                        return nil
                }

                let trackInfo = TrackInfo(title: title, artist: artist, artwork: artwork, url: url, duration: duration, id: id)
                print("Created TrackInfo: \(trackInfo)") // Print the created TrackInfo

                return trackInfo
            }
            
            // Call the completion handler to notify that the data is fetched
            completion()
        }
    }



    
}

/*
    func saveSongsToFirestore() {
        let db = Firestore.firestore()
        
        // Get the songs data
        let songsData = songsData().getSongs()
        
        // Iterate over each song and save it to Firestore
        for song in songsData {
            db.collection("songs").document("\(song.id)").setData([
                "title": song.title,
                "artist": song.artist,
                "artwork": song.artwork,
                "url": song.url,
                "duration": song.duration,
                "id": song.id
            ]) { error in
                if let error = error {
                    print("Error saving song \(song.title) to Firestore: \(error.localizedDescription)")
                } else {
                    print("Song \(song.title) successfully saved to Firestore.")
                }
            }
        }
    }

*/



