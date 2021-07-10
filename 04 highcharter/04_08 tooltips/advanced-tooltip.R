my_stack <- data_frame(
  cat = rep(c("cat a", "cat b", "cat c", "cat d", "cat e"), 5),
  subcat = rep(c("subcat u", "subcat x", "subcat y", "subcat z", "subcat w"), each = 5),
  value = round(rnorm(25, mean = 40, sd = 10)),
  label = LETTERS[1:25] #Random Assignment of alphabets
)


my_stack %>%
  hchart(type = "bar",
         hcaes(
           x = cat,
           y = value,
           group = subcat,
           name = cat
         )) %>%
  hc_plotOptions(series = list(stacking = "stack")) %>%
  hc_legend(reversed = TRUE) %>%
  hc_tooltip(
    formatter = JS( #we get all the values declared and use it - color, label, points
      "function(){ 
      
      var subcat = '';
      $.each(this.points.reverse(),function(i, point){
      subcat += '<span style=\U0022' + 'color:' + this.point.series.color + '\U0022>\u25CF</span>' + '<b>' + this.point.series.name + ': </b>' +
      Highcharts.numberFormat(this.point.plotY, 1) + ' (label: ' + this.point.label + ')' +
      '<br/>';
      });
      
      return 'Category: ' + this.points[0].key + '<br/>' +
      subcat;
      }"
    ),
    shared = TRUE
  )
