//
//  ViewController.swift
//  CarPlayMusicSampleApp
//
//  Created by Polepalli, Venkatesh on 30/01/24.
//

import UIKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var songsTableView: UITableView!
  
    
    let viewModel = MusicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       AudioManager.shared.carplayToMobileDelegate = self
        // Save songs to Firestore
              //  viewModel.saveSongsToFirestore()
        
        // Fetch songs from Firestore
               viewModel.fetchSongsFromFirestore { [weak self] in
                   // Reload the table view on the main thread after songs are fetched
                   DispatchQueue.main.async {
                       self?.songsTableView.reloadData()
                   }
               }
        
    }

}

//MARK: - TableView Delegate, DataSource
extension PlayerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.songDetailCell, for: indexPath) as? MusicDetailsTableViewCell else {
            return UITableViewCell()
        }
        let songDetails = viewModel.songs[indexPath.row]
        cell.songName.text = songDetails.title
        cell.songSinger.text = songDetails.artist
        UIImage.loadUrlImage(from: songDetails.artwork) { image in
            cell.songImage.image = image
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let musicPlayerController = storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifiers.musicPlayerViewController) as? MusicPlayerViewController {
            let selectedSong = viewModel.songs[indexPath.row]
            musicPlayerController.viewModel.songInfo = selectedSong
            AudioManager.shared.mobileToCarplayDelegate?.communicateFromMobileToCarPlay(selectedSong: selectedSong)
            self.navigationController?.pushViewController(musicPlayerController, animated: true)
        }
    }
}

//MARK: -  TableView Delegate,DataSource
//extension PlayerViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.songs.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.songDetailCell, for: indexPath) as? MusicDetailsTableViewCell else {
//               return UITableViewCell()
//           }
//        let  songDetails =   viewModel.songs[indexPath.row]
//        cell.songName.text = songDetails.title
//        cell.songSinger.text = songDetails.artist
//        UIImage.loadUrlImage(from: songDetails.artwork) { image in
//            cell.songImage.image = image
//        }
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return  120
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let musicPlayerController = storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifiers.musicPlayerViewController)as? MusicPlayerViewController{
//            let selectedSong =  viewModel.songs[indexPath.row]
//            musicPlayerController.viewModel.songInfo = selectedSong
//            AudioManager.shared.mobileToCarplayDelegate?.communicateFromMobileToCarPlay(selectedSong: selectedSong)
//            self.navigationController?.pushViewController(musicPlayerController, animated: true)
//        }
//    }
//}

//MARK: - Communication between Carplay to Mobile
extension PlayerViewController: CommunicationBetweenCarplayToMobileDelegate {//
    
    func communicateFromCarPlayToMobile(selectedSong: TrackInfo) {
          if let topViewController = navigationController?.topViewController as? MusicPlayerViewController {
              // MusicPlayerViewController is already on top, just update the songDetails
              topViewController.updateUI(with: selectedSong)
          } else if let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifiers.musicPlayerViewController) as? MusicPlayerViewController {
              vc.viewModel.songInfo = selectedSong
              // Check if the view controller is already at the top of the navigation stack
              navigationController?.pushViewController(vc, animated: true)
          }
      }
}

