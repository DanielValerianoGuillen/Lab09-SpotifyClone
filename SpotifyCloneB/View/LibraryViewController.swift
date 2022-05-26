//
//  LibraryViewController.swift
//  SpotifyCloneB
//
//  Created by MAC42 on 14/05/22.
//

import UIKit

class LibraryViewController: UIViewController {

    let playListViewModel = PlayListViewModel()
    
    var selectId: String? = nil
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setUpView()
        Task {
            await setUpData()
        }
    }
    
    func setUpData() async {
        await playListViewModel.getPlatList()
        tableView.reloadData()
    }
    
    func setUpTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setUpView() {
        imageProfile.image = HelperImage.setImageFromUrl(url: HelperString.imageProfileLink)
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width / 2
    }

}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return playListViewModel.playList?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let playList = playListViewModel.playList?.items[indexPath.section]
        cell.textLabel?.text = playList?.name
        cell.detailTextLabel?.text = playList?.itemDescription
        
        cell.imageView?.image = playList?.images.count ?? 0 > 0
        ? HelperImage.setImageFromUrl(url: playList?.images[0].url ?? "")
        : UIImage(named: "music")
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: "darkColor")
        cell.selectedBackgroundView = backgroundView

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectId = playListViewModel.playList?.items[indexPath.section].id
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let playlistDetail = segue.destination as! PlaylistDetailViewController
            playlistDetail.id = selectId
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(named: "darkColor")
        return uiView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
