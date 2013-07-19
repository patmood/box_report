//PIE CHART

  // Load the Visualization API and the piechart package.
  google.load('visualization', '1.0', {'packages':['corechart','gauge']});

  // Set a callback to run when the Google Visualization API is loaded.
  google.setOnLoadCallback(drawChart);

  // Callback that creates and populates a data table,
  // instantiates the pie chart, passes in the data and
  // draws it.
  function drawChart() {

    // Create the data table.
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Topping');
    data.addColumn('number', 'Slices');
    data.addRows([
      ['Free Space', gon.free ],
      ['Shared Data', gon.shared ],
      ['Your Data', gon.normal ],
    ]);

    // Set chart options
    var options = {'title':'Quota Used',
                   'width':400,
                   'height':300};

    var dataGauge = google.visualization.arrayToDataTable([
      ['Label', 'Value'],
      ['Usage', gon.percentage],
    ]);

    var optionsGauge = {
      width: 200, height: 200,
      greenFrom: 0, greenTo: 75,
      redFrom: 90, redTo: 100,
      yellowFrom:75, yellowTo: 90,
      minorTicks: 5
    };

    // Instantiate and draw our gauge chart, passing in some options.
    var chartGauge = new google.visualization.Gauge(document.getElementById('chart_div_gauge'));
    chartGauge.draw(dataGauge, optionsGauge);

    // Instantiate and draw our pie chart, passing in some options.
    var chart = new google.visualization.PieChart(document.getElementById('chart_div_pie'));
    chart.draw(data, options);
  }