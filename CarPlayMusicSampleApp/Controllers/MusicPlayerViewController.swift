//
//  MusicPlayerViewController.swift
//  CarPlayMusicSampleApp
//
//  Created by Polepalli, Venkatesh on 30/01/24.
//
import UIKit
import CoreMedia
import SDWebImage


class MusicPlayerViewController: UIViewController {
    
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var songImage: SDAnimatedImageView!
    @IBOutlet weak var songSlider: UISlider!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var playAndPauseButton: UIButton!
    @IBOutlet weak var backwardButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    let viewModel = MusicViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioManager.shared.musicControlsDelegate = self
        setplayer()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
        Timer().invalidate()
    }
    
    ///update UI when musicplayer is top view controller
    /// - Parameters:
    ///     - song:  updating the player if music player is top view controller
    func updateUI(with song: TrackInfo) {
        viewModel.songInfo = song
        updatePlayerDetails(song: song)
        updatePlayPauseButton()
    }
    
    @IBAction func songSliderAction(_ sender: Any) {
        AudioManager.shared.playerManager.resumeSongAt(value: Double(songSlider.value))
        AudioManager.shared.nowPlayingProgressBarDetailsInCarPlay()
        updatePlayPauseButton()
    }
    
    @IBAction func playAndPauseButtonAction(_ sender: Any) {
        if AudioManager.shared.playerManager.isPlaying {
            AudioManager.shared.playerManager.stopSong()
            changeSliderMaxValue()
        } else{
            AudioManager.shared.playerManager.playSong()
        }
        updatePlayPauseButton()
        AudioManager.shared.nowPlayingProgressBarDetailsInCarPlay()
    }
    
    @IBAction func forwardButtonAction(_ sender: Any) {
        playNextSong()
        AudioManager.shared.playerManager.playSong()
        updatePlayPauseButton()
    }
    
    @IBAction func backwardButtonAction(_ sender: Any) {
        viewModel.playPreviousSong {song in
            updatePlayerDetails(song: song)
        }
        if let songInfo = viewModel.songInfo {
            AudioManager.shared.showSongDetailsInCarplay(song: songInfo)
        }
        replaceCurrentSong()
        AudioManager.shared.playerManager.playSong()
        updatePlayPauseButton()
    }
}

//MARK: - UI Information
extension MusicPlayerViewController {
    ///Starting the player
    private func setplayer(){
        if let songInfo = viewModel.songInfo {
            AudioManager.shared.playerManager.setPlayer(url: songInfo.url)
        }
    }
    
    ///Configure UI
    private func configureUI() {
        if let songInfo = viewModel.songInfo {
            updatePlayerDetails(song: songInfo)
        }
        updatePlayPauseButton()
        changeSliderMaxValue()
    }
    
    ///Change the slider max value for every song
    private func changeSliderMaxValue() {
        songSlider.maximumValue =  viewModel.getSliderMaxValue()
    }
    
    // To play next song
    private func playNextSong(){
        viewModel.playNextSong { song in
            updatePlayerDetails(song: song)
        }
        if let songInfo = viewModel.songInfo {
            AudioManager.shared.showSongDetailsInCarplay(song: songInfo)
        }
        replaceCurrentSong()
    }
    
    ///Moving to next song once the current song is finished
    @objc private func playerDidFinishPlaying() {
        playNextSong()
        AudioManager.shared.playerManager.playSong()
        updatePlayPauseButton()
    }
    
    ///Update UI Details
    /// - Parameters:
    ///     - song:  updating the player based on current song
    private func updatePlayerDetails(song: TrackInfo) {
        if let songInfo = viewModel.songInfo {
            songImage.sd_setImage(with: URL(string: songInfo.artwork), placeholderImage: UIImage(named: Constants.Images.placeholder))
        }
        songName.text = song.title
        endTime.text = "\(song.formattedDuration)"
        songSlider.value = 0
        updateForwardandBackwardButtonStates()
    }
    
    ///Updating forward and backward button states
    private func updateForwardandBackwardButtonStates() {
        backwardButton.isEnabled = viewModel.isBackButtonEnabled
        forwardButton.isEnabled = viewModel.isForwardButtonEnabled
    }
    
    @objc private func updateSlider() {
        songSlider.value = Float(viewModel.getCurrentValueOfSlider)
        currentTime.text = viewModel.formattedCurrentTimeString(time: viewModel.getCurrentValueOfSlider)
        AudioManager.shared.nowPlayingProgressBarDetailsInCarPlay()
    }
    
    ///Rendering Image based on music player condition
    private func updatePlayPauseButton() {
        if AudioManager.shared.playerManager.isPlaying {
            playAndPauseButton.setImage(UIImage(systemName: Constants.Images.pauseFill), for: .normal)
        } else {
            playAndPauseButton.setImage(UIImage(systemName: Constants.Images.playFill ), for: .normal)
        }
    }
    
    /// replace the current song  with new song and updating the current song info
    private func replaceCurrentSong() {
        if let songInfo = viewModel.songInfo {
            AudioManager.shared.playerManager.replaceCurrentSong(songUrl: songInfo.url)
            AudioManager.shared.updateSongInfoDelegate?.changeSongInfo(selectedSong: songInfo)
        }
    }
}
//MARK: - Music Controls Delegate,  to mobileupdate current song from carplay to mobile
extension MusicPlayerViewController: MusicControlsDelegate {
    func playCurrentSong() {
        updatePlayPauseButton()
    }
    
    func pauseCurrentSong() {
        updatePlayPauseButton()
    }
    
    func nextSong(song: TrackInfo) {
        viewModel.songInfo = song
        updatePlayerDetails(song: song)
        updatePlayPauseButton()
    }
    
    func previousSong(song: TrackInfo) {
        viewModel.songInfo = song
        updatePlayerDetails(song: song)
        updatePlayPauseButton()
    }
}



