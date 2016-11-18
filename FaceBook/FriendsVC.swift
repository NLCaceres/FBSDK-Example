//
//  FriendsVC.swift
//  FaceBook
//
//  Created by Administrator on 10/5/16.
//  Copyright © 2016 ITP344. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class FriendsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var friendsTableView: UITableView!
    
    var friendNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendNames = []
        friendsTableView.reloadData()
        
        if(FBSDKAccessToken.current().hasGranted("user_friends")){
            
            // perform graph request
            let graphRequest = FBSDKGraphRequest(graphPath: "/me/taggable_friends?limit=1000", parameters: nil)
            
            graphRequest?.start(completionHandler: {
                (connection, result, error) -> Void in
                
                if (error == nil) {
                    // Way to cast in swift that ensures I know what I am getting
                    // Otherwise use optional form if any uncertainty of course
                    let resultDict = result as! [String:Any]
                    
                    let friends = resultDict["data"] as! [[String:Any]]
                    // Data string acts as a key for the dictionary always will in this request
                    
                    for friend in friends {
                        let name = friend["name"] as! String
                        self.friendNames.append(name)
                        
                    }
                    self.friendsTableView.reloadData()
                    print(result)
                }
                else {
                    
                    /*
                    
                    // Way to cast in swift that ensures I know what I am getting
                    // Otherwise use optional form if any uncertainty of course
                    let resultDict = result as! [String:Any]
                    
                    let friends = resultDict["data"] as! [[String:Any]]
                    // Data string acts as a key for the dictionary always will in this request
                    
                    for friend in friends {
                        let name = friend["name"] as! String
                        self.friendNames.append(name)
 
                    }
                    */
                }
                
            })
            
            
        }else{
            print("user_freinds access not granted")
            
        }
		
		
	
	}
	@IBAction func closeButtonTouched(_ sender: AnyObject) {
		
		self.dismiss(animated: true, completion: nil)
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    let cellId = "cellId1"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.text = friendNames[(indexPath as NSIndexPath).row]
        
        return cell!
    }

}
