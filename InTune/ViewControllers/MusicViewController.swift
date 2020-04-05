//
//  MusicViewController.swift
//  InTune
//
//  Created by Akashlal on 28/03/20.
//  Copyright © 2020 AkOS. All rights reserved.
//

import UIKit



class MusicViewController: UIViewController {
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var guideView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private let viewModel = InTuneModel.sharedInstance()
    
    var musicItems: [MusicItem]?
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //manager.delegate = self
        // Do any additional setup after loading the view.
        title = "InTune Music"
        
        //Bindings
        viewModel.loaderVisible.bind{[weak self] shown in
            DispatchQueue.main.async {
                self?.loaderView.isHidden = !shown
            }
        }
        viewModel.guideViewShown.bind{[weak self] shown in
            DispatchQueue.main.async {
                self?.guideView.isHidden = !shown
            }
        }
        viewModel.errorLabelText.bind{[weak self] error in
            DispatchQueue.main.async {
                self?.errorLabel.text = error
            }
        }
        viewModel.musicItems.bind{[weak self] items in
            self?.musicItems = items
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue"{
            if let vc = segue.destination as? MusicDetailViewController{
                vc.musicItem = musicItems![selectedIndex]
            }
        }
    }

}


//MARK:- TableView Methods
extension MusicViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicItems?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath)
        guard let currentItem = musicItems?[indexPath.row],
            let trackName = currentItem.trackCensoredName,
            let genre = currentItem.primaryGenreName,
            let artistName = currentItem.artistName,
            let trackPrice = currentItem.trackPrice,
            let trackImageString = currentItem.artworkUrl100,
            let trackImageURL = URL(string: trackImageString)
            else { return cell}
        if let cell = cell as? MusicItemCell{
            cell.trackName.text = trackName
            cell.trackSubtitle.text = "\(genre) - \(artistName)"
            cell.trackDuration.text = currentItem.trackTimeString
            cell.trackPrice.text = "\(abs(trackPrice))"
            cell.trackImageLink = trackImageURL
        }
        return cell
    }
}

extension MusicViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowDetailSegue", sender: self)
    }
}

extension MusicViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let txt = searchBar.text else {
                return
            }
        viewModel.getSearchResultsFor(query: txt)
        searchBar.resignFirstResponder()
    }

}
