//
//  GithubRepoTableViewCell.swift
//  GithubDemo
//
//  Created by Nick McDonald on 1/27/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class GithubRepoTableViewCell: UITableViewCell {

    @IBOutlet weak var authorAvatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var repoStarsLabel: UILabel!
    @IBOutlet weak var repoForksLabel: UILabel!
    
    var repo: GithubRepo! {
        
        didSet {
            self.setUpBoldedRepoName()
            self.authorAvatarImageView.setImageWith(URL(string: self.repo.ownerAvatarURL!)!)
            self.repoDescriptionLabel.text = self.repo.repoDescription ?? "No description provided."
            self.repoStarsLabel.text = CommaInserter.insertCommas(into: self.repo.stars!)
            self.repoForksLabel.text = CommaInserter.insertCommas(into: self.repo.forks!)
        }
    }
    
    private func setUpBoldedRepoName() {
        let authorAndRepoName: String = "\(self.repo.ownerHandle!) / "
        let numOfCharsInAuthor: Int = authorAndRepoName.characters.count
        let numOfCharsInRepo: Int = self.repo.name!.characters.count
        let totalString: String = authorAndRepoName + self.repo.name!
        let range: NSRange = NSRange(location: numOfCharsInAuthor, length: numOfCharsInRepo)
        self.authorLabel.attributedText = self.attributedString(from: totalString, boldRange: range)
    }
    
    private func attributedString(from string: String, boldRange: NSRange) -> NSMutableAttributedString {
        let fontSize = CGFloat(20.0)
        let attrs = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: fontSize)]
        let nonBoldAttribute = [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)]
        let attrString = NSMutableAttributedString(string: string, attributes: nonBoldAttribute)
        attrString.setAttributes(attrs, range: boldRange)
        return attrString
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.authorAvatarImageView.layer.cornerRadius = 4.0
        self.authorAvatarImageView.layer.borderColor = UIColor.black.cgColor
        self.authorAvatarImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
