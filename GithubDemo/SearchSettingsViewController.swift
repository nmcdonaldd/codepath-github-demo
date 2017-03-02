//
//  SearchSettingsViewController.swift
//  GithubDemo
//
//  Created by Nick McDonald on 3/1/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

protocol SettingsPresentingViewControllerDelegate: class {
    func didSaveSettings(settings: GithubRepoSearchSettings)
    func didCancelSettings()
}

class SearchSettingsViewController: UITableViewController {
    
    weak var delegate: SettingsPresentingViewControllerDelegate?
    @IBOutlet var settingsTableView: UITableView!
    var settings: GithubRepoSearchSettings!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.delegate?.didCancelSettings()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        self.delegate?.didSaveSettings(settings: self.settings)
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchSettingsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Minimum Stars"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchSettingsWithSliderTableViewCell = self.settingsTableView.dequeueReusableCell(withIdentifier: "SearchSettingsWithSliderTableViewCell", for: indexPath) as! SearchSettingsWithSliderTableViewCell
        cell.delegate = self
        cell.numOfStars = self.settings?.minStars ?? 0
        return cell
    }
}

extension SearchSettingsViewController: SearchSettingsWithSliderDelegate {
    func starsSliderChangedValue(_ value: Int) {
        var newGitHubSettings = self.settings
        newGitHubSettings?.minStars = value
        self.settings = newGitHubSettings
    }
}
