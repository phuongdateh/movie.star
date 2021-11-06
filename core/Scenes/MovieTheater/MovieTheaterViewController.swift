//
//  MovieTheaterViewController.swift
//  core
//
//  Created by Doan Duy Phuong on 03/11/2021.
//

import UIKit
import CoreLocation

class MovieTheaterViewController: ViewController<MovieTheaterViewModel> {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationTitle = "Cinema"
        tableView.registerCell(ofType: MovieTheaterTableViewCell.self)
        tableView.backgroundColor = .clear
        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self

        view.backgroundColor = ColorPalette.background
        
        tableView.addRefreshHeader { [weak self] in
            self?.fetchData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLocationService()
    }

    private func setupLocationService() {
        let service = LocationService.shared
        service.delegate = self

        guard service.locationServiceEnabled else {
            // Should show popup
            return
        }

        guard service.isReady else {
            // Should open Settings
            service.requestLocationService()
            return
        }
    }

    private func fetchData() {
//        startLoading()
        viewModel.retrieveNearMovieTheater(success: { [weak self] in
            self?.updateView()
            self?.stopLoading()
        }, failure: { [weak self] in
            self?.stopLoading()
        })
    }

    private func startLoading() {
        tableView.headerBeginRefreshing()
    }

    private func stopLoading() {
        tableView.headerEndRefreshing(completion: nil)
    }

    private func updateView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension MovieTheaterViewController: LocationServiceDelegate {
    func locationManagerDidFetchLocation(_ location: CLLocation) {
        print(">>>>>>>>>>>>>>>>>>>>")
        fetchData()
    }

    func locationServiceDidChangeAuthorization(status: CLAuthorizationStatus) {
        guard status == .authorizedAlways || status == .authorizedWhenInUse else { return }
        LocationService.shared.startGettingLocation()
    }
}

extension MovieTheaterViewController: UITableViewDelegate,
                                      UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: MovieTheaterTableViewCell.self, at: indexPath)
        cell.selectionStyle = .none
        cell.configure(data: viewModel.cellData(indexPath: indexPath))
        return cell
    }
}
