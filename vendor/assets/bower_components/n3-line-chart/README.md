# n3-line-chart [![Build Status](https://travis-ci.org/n3-charts/line-chart.svg?branch=master)](https://travis-ci.org/n3-charts/line-chart)

n3-line-chart makes creating beautiful charts for [AngularJS](http://angularjs.org/) applications easy and semantic. It is built on top of [D3.js](http://d3js.org/).

You can find examples on the [demo page](http://n3-charts.github.io/line-chart/).

### How to install
 + Install using bower : `bower install n3-line-chart` (or copy `line-chart.min.js` wherever you want)
 + Reference `line-chart.min.js` in your index.html file
 + Reference the module in your app file :
    ```
    angular.module('myApp', ['n3-line-chart'])
    ```

> The module was originally named `n3-charts.linechart`. This is still valid but will probably be removed in the future.

### How to use
A line chart is called using this syntax :

```html
<linechart data="data" options="options" mode=""></linechart>
```

The line chart directives needs two attributes : `data` and `options`. If one is missing, nothing happens.

#### Data
Your data should look like this :

```js
$scope.data = [
  {x: 0, value: 4, otherValue: 14},
  {x: 1, value: 8, otherValue: 1},
  {x: 2, value: 15, otherValue: 11},
  {x: 3, value: 16, otherValue: 147},
  {x: 4, value: 23, otherValue: 87},
  {x: 5, value: 42, otherValue: 45}
];
```

#### Options
Options must be an object with a series array. It should look like this :

```js
$scope.options = {
  axes: {
    x: {key: 'x', labelFunction: function(value) {return value;}, type: 'linear', tooltipFormatter: function(x) {return x;}},
    y: {type: 'linear', min: 0, max: 1},
    y2: {type: 'linear', min: 0, max: 1}
  },
  series: [
    {y: 'value', color: 'steelblue', thickness: '2px', type: 'area', striped: true, label: 'Pouet'},
    {y: 'otherValue', axis: 'y2', color: 'lightsteelblue', visible: false}
  ],
  lineMode: 'linear',
  tension: 0.7,
  tooltipMode: 'dots',
  drawLegend: true,
  drawDots: true
}
```
##### Axes
The `axes` keys can be undefined. Otherwise, it can contain an `x̀` key with the following properties :

 + `key` : optional, defines where the chart will look for abscissas values in the data (default is 'x').
 + `tooltipFormatter` : optional, allows to format the tooltip. Must be a function that accepts a single argument, the x value. It should return something that will be converted into a string and put in the x tooltip.
 + `type` : optional, can be either 'date' or 'linear' (default is 'linear'). If set to 'date', the chart will expect Date objects as abscissas. No transformation is done by the chart itself, so the behavior is basically D3.js' time scale's.
 + `labelFunction` : optional, allows to format the axis' ticklabels. Must be a function that accepts a single argument and returns a string.

It can also contain, according to your series configuration, a `y` and a `y2` key with the following properties :

 + `type` : optional, can be either linear' or 'log' (default is 'linear'). If set to 'log', the data may be clamped if its computed lower bound is 0 (this means the chart won't display an actual 0, but a close value - log scales can't display zero values).
 + `min` : optional, forces the axis minimum value (default is computed from data)
 + `max` : optional, forces the axis maximum value (default is computed from data)


##### Series
The `series` key must be an array which contains objects with the following properties :

+ `y` : mandatory, defines which property on each data row will be used as ordinate value.
+ `color` : optional, any valid HTML color (if none given, the chart will set it for you).
+ `label` : optional, will be used in the legend (if undefined, the `y` value will be used).
+ `axis` : optional, can be either 'y' (default, for left) or 'y2' (for right). Defines which vertical axis should be used for this series. If no right axis is needed, none will be displayed.
+ `type` : optional, can be one value between 'line', 'area', 'column'. Default is 'line'.
+ `striped` : optional, can be either `true` or `false`. Default is `false`. Will be ignored if the series type is not 'area'.
+ `thickness` : optional, can be `{n}px`. Default is `1px`. Will be ignored if the series type is not 'area' or 'line'.
+ `visible` : optional, can be either `true` or `false`. Default is true. Defines whether the series is initially visible. Will be updated if the series gets hidden or shown through a click on the legend.

##### Optional stuff
Additionally, you can set `lineMode` to a value between these :

+ linear *(default)*
+ step-before
+ step-after
+ basis
+ basis-open
+ basis-closed
+ bundle
+ cardinal
+ cardinal-open
+ cadinal-closed
+ monotone

The `tension` can be set, too (default is `0.7`). See [issue #44][2] about that.

> For more information about interpolation, please consult the [D3.js documentation about that][1].

The `tooltipMode` can be set to `none`, `dots`, `lines` or `both`. It can also be set to `scrubber`, which displays tooltips for all series.

The `drawLegend` and `drawDots` are optional. They respectively enable/disable the chart's legend and the lines and areas dots. Default is `true` for both.

#### Mode
The mode can be set to 'thumbnail' (default is empty string). If so, the chart will take as much space as it can, and it will only display the series. No axes, no legend, no tooltips. Furthermore, the lines or areas will be drawn without dots. This is convenient for sparklines.

### Building
Fetch the repo :
```sh
$ git clone https://github.com/n3-charts/line-chart.git
```

Install dev dependencies :
```sh
$ npm install
```

Install components :
```sh
$ bower install
```

Watch :
```sh
$ grunt watch
```

Or just build :
```sh
$ grunt
```

Or run the visual tests, too :
```sh
$ grunt travis
```


### Testing
AngularJS is designed to build testable apps, so is this project.
It has a good coverage rate (above 95%), let's keep it this way.

  [1]: https://github.com/mbostock/d3/wiki/SVG-Shapes#wiki-line_interpolate
  [2]: https://github.com/n3-charts/line-chart/issues/44
