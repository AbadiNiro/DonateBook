//
//  ItemListViewController.swift
//  DonateBook
//
//  Created by admin on 06/07/2021.
//  Copyright © 2021 donatebook. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var ItemTableView: UITableView!



    override func viewDidLoad() {
        super.viewDidLoad()
    }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "toAddDonateSegue"){
                print("dsas")
            }
        }
        @IBAction func backToMyDonations(segue: UIStoryboardSegue){
            print("Back to myDonation screen")
        }
    
//UITableViewDelegate
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = ItemTableView.dequeueReusableCell(withIdentifier: "itemListRow")
    return cell!
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


