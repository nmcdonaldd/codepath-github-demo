//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDelegate {

    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings(numOfStars: 0)

    var repos: [GithubRepo]!

    @IBOutlet weak var repoResultsTableView: UITableView!
    @IBOutlet weak var searchSettingsBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        self.repoResultsTableView.dataSource = self
        self.repoResultsTableView.delegate = self
        self.repoResultsTableView.rowHeight = UITableViewAutomaticDimension
        self.repoResultsTableView.estimatedRowHeight = 195
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShown(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDismissed(notification:)), name: .UIKeyboardWillHide, object: nil)

        // Perform the first search when the view controller first loads
        doSearch()
    }
    
    @IBAction func searchSettingsButtonTapped(_ sender: Any) {
//        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let reposSearchSettingsNavVC: UINavigationController = storyboard.instantiateViewController(withIdentifier: "SearchSettingsNavigationController") as! UINavigationController
//        self.present(reposSearchSettingsNavVC, animated: true, completion: nil)
    }
    
    
    // MARK: - NotificationCenter Observers
    
    @objc private func keyboardDismissed(notification: Notification) {
        self.repoResultsTableView.contentInset.bottom = 0
    }
    
    @objc private func keyboardShown(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.repoResultsTableView.contentInset.bottom = keyboardSize.height
        }
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
            }
            self.repos = newRepos
            self.repoResultsTableView.reloadData()

            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error?.localizedDescription)
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let vc = navController.topViewController as! SearchSettingsViewController
        //vc.settings =   // ... Search Settings ...
        vc.settings = self.searchSettings
        vc.delegate = self
    }
}


extension RepoResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let repos = self.repos {
            return repos.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.repoResultsTableView.dequeueReusableCell(withIdentifier: "GithubTableViewCell") as! GithubRepoTableViewCell
        cell.repo = self.repos[indexPath.row]
        
        return cell
    }
}

extension RepoResultsViewController: SettingsPresentingViewControllerDelegate {
    func didCancelSettings() {
        //Nothing really.
    }
    func didSaveSettings(settings: GithubRepoSearchSettings) {
        self.searchSettings = settings
        self.doSearch()
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
