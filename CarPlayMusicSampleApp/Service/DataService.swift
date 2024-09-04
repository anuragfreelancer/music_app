//
//  DataService.swift
//  CarPlayMusicSampleApp
//
//  Created by Polepalli, Venkatesh on 03/02/24.
//

import Foundation


class songsData{

    func getSongs() -> [TrackInfo] {
        return songs
    }
    
   private let songs = [
        TrackInfo(
            title: "death bed",
            artist: "Powfu",
            artwork: "https://upload.wikimedia.org/wikipedia/en/3/3e/Powfu_-_Death_Bed.png",
            url: "https://sample-music.netlify.app/death%20bed.mp3",
            duration: 2 * 60 + 53,
            id: 09
        ),
        TrackInfo(
            title: "bad liar",
            artist: "Imagine Dragons",
            artwork: "https://c.saavncdn.com/020/I-m-a-Bad-Liar-English-2019-20210717101608-500x500.jpg",
            url: "https://sample-music.netlify.app/Bad%20Liar.mp3",
            duration: 4 * 60 + 20,
            id: 1
        ),
        TrackInfo(
            title: "faded",
            artist: "Alan Walker",
            artwork: "https://pbs.twimg.com/profile_images/1718294723293548545/zt1Tpc23_400x400.jpg",
            url: "https://sample-music.netlify.app/Faded.mp3",
            duration: 3 * 60 + 33 ,
            id: 25
        ),
        TrackInfo(
            title: "hate me",
            artist: "Ellie Goulding",
            artwork: "https://i.ytimg.com/vi/UZwi9SHgzGY/hqdefault.jpg?v=5ec3eb7d",
            url: "https://sample-music.netlify.app/Hate%20Me.mp3",
            duration: 3 * 60 + 6,
            id: 38
        ),
        TrackInfo(
            title: "Solo",
            artist: "Clean Bandit",
            artwork: "https://yt3.googleusercontent.com/h-HZwqHyWHmluf-WQnJx7ujd65aUWAcmAwPewryzirhR-hBV112x_5mPE_J6VCY5nUnNFRzDPQ=s900-c-k-c0x00ffffff-no-rj",
            url: "https://sample-music.netlify.app/Solo.mp3",
            duration: 3 * 60 + 45,
            id: 42
        ),
        TrackInfo(
            title: "without me",
            artist: "Halsey",
            artwork: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZOgTu4wnOt-SS0BkGO142jL8_sDkxmp9PnA&usqp=CAU",
            url: "https://sample-music.netlify.app/Without%20Me.mp3",
            duration: 3 * 60 + 49,
            id: 61
        )
    ]

}
