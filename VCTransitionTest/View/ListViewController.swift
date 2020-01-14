//
//  ListViewController.swift
//  VCTransitionTest
//
//  Created by Dima Panchuk on 08.01.2020.
//  Copyright © 2020 dpanchuk. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, ViewTransitioning {

    @IBOutlet weak var tableView: UITableView!
    
    var transitioningView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }

}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ItemCell
        transitioningView = cell.detailImageView
        pushDetailVC(with: cell.detailImageView?.image)
    }
    
    private func pushDetailVC(with image: UIImage?) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailVC") as! DetailViewController
        _ = detailVC.view
        detailVC.imageView.image = image
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? ItemCell else { return UITableViewCell() }
        cell.detailImageView?.image = indexPath.row.isMultiple(of: 2) ? UIImage(named: "pic1")! : UIImage(named: "pic2")!
        cell.label?.text = "Some item description"
        return cell
    }
    
}
