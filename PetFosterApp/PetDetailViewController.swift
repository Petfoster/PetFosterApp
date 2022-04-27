//
//  PetDetailViewController.swift
//  PetFosterApp
//
//  Created by Niko Holbrook on 4/20/22.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class PetDetailViewController: UIViewController, MessageInputBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var listing: PFObject!
    var comments =  [PFObject]()
    
    var showsCommentBar = false;
    let commentBar = MessageInputBar()

    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailAgeLabel: UILabel!
    @IBOutlet weak var detailSpeciesLabel: UILabel!
    @IBOutlet weak var detailDescTitle: UILabel!
    @IBOutlet weak var detailDescLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comments = (listing["comments"] as? [PFObject]) ?? []
        
        let name = listing["name"] as! String
        detailNameLabel.text = name
        
        let age = listing["age"] as! Int
        detailAgeLabel.text = String(age) + " year(s)"
        detailSpeciesLabel.text = listing["species"] as? String
        
        detailDescTitle.text = "About " + name
        detailDescLabel.text = listing["description"] as? String
        
        detailDescLabel.sizeToFit()
        
        let imageFile = listing["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        detailImageView.af.setImage(withURL: url)
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        commentBar.inputTextView.placeholder = "Add a comment"
        commentBar.sendButton.title = "Submit"
        commentBar.delegate = self
    }
    
        func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
            //create the comment
            
            
    
            let comment = PFObject(className: "Comments")
    
            comment["text"] = text
            comment["author"] = PFUser.current()!
            comment["listing"] = listing
    
            listing.add(comment, forKey: "comments")
    
            listing.saveInBackground{(success,error) in
                if success{
                    print("Comment saved")
                } else {
                    print("Error saving comment")
                }
            }
            detailTableView.reloadData()
            //clear and dismiss input bar
            commentBar.inputTextView.text = nil
            showsCommentBar = false
            becomeFirstResponder()
            commentBar.inputTextView.resignFirstResponder()
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == comments.count {
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < comments.count {

            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell

            let comment = comments[indexPath.row]
            cell.commentLabel.text = comment["text"] as? String

            let user = comment["author"] as! PFUser
            cell.authorLabel.text = user.username

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            return cell
        }
        
    }
    
    @objc func keyboardWillBeHidden(note: Notification){
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
    }
    
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsCommentBar
    }
    
    @IBAction func adoptPet(_ sender: Any) {
        listing.setValue(PFUser.current()!, forKey: "claimedBy")
        listing.saveInBackground{(success,error) in
            if success{
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error claiming pet")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
