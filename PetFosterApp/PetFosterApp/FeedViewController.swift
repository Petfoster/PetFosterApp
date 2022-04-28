//
//  FeedViewController.swift
//  PetFoster
//  CURRENT
//  Created by Nick Flores on 4/11/22.
//

import UIKit
import Parse

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,MessageInputBarDelegate{
    
    
    var listings = [PFObject]()
    let commentBar = MessageInputBar()
    @IBOutlet weak var tableView: UITableView!
    var showsCommentBar = false;
    var selectedPost: PFObject!
    var numberOfListings: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentBar.inputTextView.placeholder = "Add a comment"
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
        numberOfListings = 20
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        myRefreshControl.addTarget(self, action: #selector(loadListings), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        
        loadListings()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadListings()
    }
    
    @objc func loadListings() {
        let query = PFQuery(className: "Listing")
        query.includeKeys(["name", "age", "species"])
        query.limit = numberOfListings
        query.findObjectsInBackground{ (posts, error) in
            if posts != nil {
                self.listings = posts!
                self.myRefreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard (name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginViewController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listings.count
    }
    
//    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
//        //create the comment
//
//        let comment = PFObject(className: "Comments")
//
//        comment["text"] = text
//        comment["post"] = selectedPost
//        comment["author"] = PFUser.current()!
//
//        selectedPost.add(comment, forKey: "comments")
//
//        selectedPost.saveInBackground{(success,error) in
//            if success{
//                print("Comment saved")
//            } else {
//                print("Error saving comment")
//            }
//        }
//        tableView.reloadData()
//        //clear and dismiss input bar
//        commentBar.inputTextView.text = nil
//        showsCommentBar = false
//        becomeFirstResponder()
//        commentBar.inputTextView.resignFirstResponder()
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listing = listings[indexPath.section]
        // let comments = (post["comments"] as? [PFObject]) ?? []
        
            //Main Post Cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
            let petName = listing["name"] as! String
            cell.petNameLabel.text = petName
        
            let species = listing["species"] as! String
            
            cell.speciesLabel.text! = "Species: " + species
            
            let age = listing["age"] as! Int
            
            cell.ageLabel.text = "Age: " + String(age) + " year(s)"
            
            let imageFile = listing["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            
            cell.photoView.af.setImage(withURL: url)
            
            return cell
    }
    
<<<<<<< Updated upstream:PetFosterApp/PetFosterApp/FeedViewController.swift
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let post = listings[indexPath.section]
//        // let comments = (post["comments"] as? [PFObject]) ?? []
//        
//        print(post)
////        print(indexPath.row,comments.count+1)
////        if indexPath.row == comments.count+1 {
////            showsCommentBar = true
////            becomeFirstResponder()
////            commentBar.inputTextView.becomeFirstResponder()
////            selectedPost = post
////        }
//        
//    }

=======
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for:cell)!
        let listing = listings[indexPath.section]
        
        let detailsViewController = segue.destination as! PetDetailViewController
        detailsViewController.listing = listing
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
>>>>>>> Stashed changes:PetFosterApp/FeedViewController.swift
}
