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
            self.authorAvatarImageView.setImageWith(URL(string: self.repo.ownerAvatarURL!)!)
            self.repoDescriptionLabel.text = self.repo.repoDescription!
            self.repoStarsLabel.text = String(self.repo.stars!)
            self.repoForksLabel.text = String(self.repo.forks!)
            self.authorLabel.preferredMaxLayoutWidth = self.authorLabel.frame.width
            self.repoDescriptionLabel.preferredMaxLayoutWidth = self.repoDescriptionLabel.frame.width
            self.setUpBoldedRepoName()
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.authorLabel.preferredMaxLayoutWidth = self.authorLabel.frame.width
        self.repoDescriptionLabel.preferredMaxLayoutWidth = self.repoDescriptionLabel.frame.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
