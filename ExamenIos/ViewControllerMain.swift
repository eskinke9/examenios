//
//  ViewControllerMain.swift
//  ExamenIos
//
//  Created by Enrique on 22/12/21.
//

import UIKit
import Alamofire
import Charts

class ViewControllerMain: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    let players = ["Ozil", "Ramsey", "Laca", "Auba", "Xhaka", "Torreira"]
    let goals = [6, 8, 26, 30, 8, 10]
    @IBOutlet weak var tableViewCharts: UITableView!
    var listQuestions:[Question] = []
    var colors: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getData()

    }
    
    /*func customizeChart(dataPoints: [String], values: [Double]) ->  PieChartData {
        // 1. Set ChartDataEntry
           var dataEntries: [ChartDataEntry] = []
           for i in 0..<dataPoints.count {
             let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data:  dataPoints[i] as AnyObject)
             dataEntries.append(dataEntry)
           }
           
           // 2. Set ChartDataSet
           let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
           pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
           
           // 3. Set ChartData
           let pieChartData = PieChartData(dataSet: pieChartDataSet)
           let format = NumberFormatter()
           format.numberStyle = .none
           let formatter = DefaultValueFormatter(formatter: format)
           pieChartData.setValueFormatter(formatter)
           
           // 4. Assign it to the chart's data
           return pieChartData
    }*/
    
   /* private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<numbersOfColor {
          let red = Double(arc4random_uniform(256))
          let green = Double(arc4random_uniform(256))
          let blue = Double(arc4random_uniform(256))
          let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
          colors.append(color)
        }
        return colors
    }*/
    
    func getData(){
        if Connectivity.isConnectedToInternet(){
            let request = AF.request("https://us-central1-bibliotecadecontenido.cloudfunctions.net/helloWorld")
                request.responseDecodable(of: Welcome.self){ (response) in
                    guard let questions = response.value else {return }
                    self.listQuestions = questions.questions
                    self.colors = questions.colors
                    self.tableViewCharts.reloadData()
                }
        }else{
            AlertString.alert(messageText: "Verifica tu conexión a internet", onView: self)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CellC", for: indexPath) as! TableViewCellCharts
        cell.titleChart.text = listQuestions[indexPath.row].text
        cell.viewChart.data = createChart(chartData: listQuestions[indexPath.row].chartData)
        cell.viewChart.drawEntryLabelsEnabled = false
        cell.viewChart.holeRadiusPercent = 0.9
        cell.viewChart.transparentCircleRadiusPercent = 0.0
        cell.viewChart.holeColor = UIColor(red: 234/255, green: 241/255, blue: 253/255, alpha: 1)
        return cell
    }
    
    func createChart(chartData: [ChartData]) ->  PieChartData {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<chartData.count {
            let dataEntry = PieChartDataEntry(
                value: Double(chartData[i].percetnage),
                label: chartData[i].text + " " + String(chartData[i].percetnage) + "%",
                data:  chartData[i].text as AnyObject)
            dataEntries.append(dataEntry)
        }

        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: chartData.count)

        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setDrawValues(false)
        
        return pieChartData
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
         print(colors)
         var colorsChart: [UIColor] = []
         for _ in 0..<numbersOfColor {
           let red = Double(arc4random_uniform(256))
           let green = Double(arc4random_uniform(256))
           let blue = Double(arc4random_uniform(256))
           let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
           colorsChart.append(color)
         }
        return colorsChart
     }

}
                            
