//
//  ViewController.swift
//  HydrationTracker
//
//  Created by Sudharshan on 15/06/24.
//

import UIKit
import CoreData

class WaterIntakeViewController: UIViewController {
    
    @IBOutlet weak var waterIntakeTableView: UITableView!
    
    var waterLogs: [WaterLogs] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }

    func configureUI() {
        
        self.waterIntakeTableView.delegate = self
        self.waterIntakeTableView.dataSource = self
        self.waterIntakeTableView.separatorStyle = .none
        
        self.waterIntakeTableView.register(UINib(nibName: "WaterTakenTableViewCell", bundle: nil), forCellReuseIdentifier: "WaterLogCell")
        
        self.title = "Hydration Tracker"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWaterLog))
        
        fetchWaterLogs()
    }
    
    func fetchWaterLogs() {
            let fetchRequest: NSFetchRequest<WaterLogs> = WaterLogs.fetchRequest()

            do {
                waterLogs = try CoreDataStack.shared.context.fetch(fetchRequest)
                waterIntakeTableView.reloadData()
            } catch {
                print("Failed to fetch water logs: \(error)")
            }
        }

        @objc func addWaterLog() {
            let alert = UIAlertController(title: "Add Water Intake", message: nil, preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "Amount in ml"
                textField.keyboardType = .numberPad
            }
            let addAction = UIAlertAction(title: "Add", style: .default) { _ in
                guard let textField = alert.textFields?.first, let text = textField.text, let amount = Double(text) else { return }
                self.saveWaterLog(amount: amount)
            }
            alert.addAction(addAction)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }

        func saveWaterLog(amount: Double) {
            let waterLog = WaterLogs(context: CoreDataStack.shared.context)
            waterLog.id = UUID()
            waterLog.date = Date()
            waterLog.amount = amount
            CoreDataStack.shared.saveContext()
            fetchWaterLogs()
        }
    
    @objc func editOptionClicked(_ sender: UIButton) {
        
        let index = sender.tag
        
        let alert = UIAlertController(title: "Edit Water Intake", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Amount in ml"
            textField.keyboardType = .numberPad
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let textField = alert.textFields?.first, let text = textField.text, let amount = Double(text) else { return }
            self.waterLogs[index].amount = amount
            CoreDataStack.shared.saveContext()
            self.waterIntakeTableView.reloadData()
        }
        alert.addAction(addAction)
        
        // Present the alert
        present(alert, animated: true, completion: nil)
    }

}

extension WaterIntakeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waterLogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WaterLogCell", for: indexPath) as? WaterTakenTableViewCell
        cell?.editButton.tag = indexPath.row
        cell?.editButton.addTarget(self, action: #selector(editOptionClicked(_ :)), for: .touchUpInside)
        let waterLog = waterLogs[indexPath.row]
        cell?.intakeMeasureLabel.text = "\(waterLog.amount) ml"
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        cell?.intakeDate.text = dateFormatter.string(from: waterLog.date ?? Date())
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let waterLog = waterLogs[indexPath.row]
            CoreDataStack.shared.context.delete(waterLog)
            CoreDataStack.shared.saveContext()
            fetchWaterLogs()
        }
    }
    
}
