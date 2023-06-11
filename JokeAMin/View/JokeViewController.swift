//
//  ViewController.swift
//  JokeAMin
//
//  Created by Pooja on 10/06/23.
//

import UIKit

class JokeViewController: UIViewController {
    
    private var tableView: UITableView!
    private var viewModel: JokeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.stopFetching()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        headerView.backgroundColor = UIColor.blue

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height))
        label.text = "Joke-A-Min"
        label.textColor = UIColor.white
        label.textAlignment = .center

        headerView.addSubview(label)
        tableView.tableHeaderView = headerView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(JokeTableViewCell.self, forCellReuseIdentifier: "JokeTableViewCell")
        view.addSubview(tableView)
    }

    private func setupViewModel() {
        viewModel = JokeViewModel()
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.getDataEveryMinute()
    }
}

extension JokeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.numberOfRows
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JokeTableViewCell", for: indexPath) as? JokeTableViewCell else { return UITableViewCell() }
        cell.populateData(with: viewModel.titleForRow(at: indexPath.row))
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        estimatedHeightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
}
