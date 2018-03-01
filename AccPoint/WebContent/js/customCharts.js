//Custom Pie
    	
    	Chart.defaults.pieLabels = Chart.helpers.clone(Chart.defaults.pie);

    		var helpers = Chart.helpers;
    		var defaults = Chart.defaults;

    		Chart.controllers.pieLabels = Chart.controllers.pie.extend({
    			updateElement: function(arc, index, reset) {
    		    var _this = this;
    		    var chart = _this.chart,
    		        chartArea = chart.chartArea,
    		        opts = chart.options,
    		        animationOpts = opts.animation,
    		        arcOpts = opts.elements.arc,
    		        centerX = (chartArea.left + chartArea.right) / 2,
    		        centerY = (chartArea.top + chartArea.bottom) / 2,
    		        startAngle = opts.rotation, // non reset case handled later
    		        endAngle = opts.rotation, // non reset case handled later
    		        dataset = _this.getDataset(),
    		        circumference = reset && animationOpts.animateRotate ? 0 : arc.hidden ? 0 : _this.calculateCircumference(dataset.data[index]) * (opts.circumference / (2.0 * Math.PI)),
    		        innerRadius = reset && animationOpts.animateScale ? 0 : _this.innerRadius,
    		        outerRadius = reset && animationOpts.animateScale ? 0 : _this.outerRadius,
    		        custom = arc.custom || {},
    		        valueAtIndexOrDefault = helpers.getValueAtIndexOrDefault;

    		    helpers.extend(arc, {
    		      // Utility
    		      _datasetIndex: _this.index,
    		      _index: index,

    		      // Desired view properties
    		      _model: {
    		        x: centerX + chart.offsetX,
    		        y: centerY + chart.offsetY,
    		        startAngle: startAngle,
    		        endAngle: endAngle,
    		        circumference: circumference,
    		        outerRadius: outerRadius,
    		        innerRadius: innerRadius,
    		        label: valueAtIndexOrDefault(dataset.label, index, chart.data.labels[index])
    		      },

    		      draw: function () {
    		      	var ctx = this._chart.ctx,
    								vm = this._view,
    								sA = vm.startAngle,
    								eA = vm.endAngle,
    								opts = this._chart.config.options;
    						
    							var labelPos = this.tooltipPosition();
    							var segmentLabel = vm.circumference / opts.circumference * 100;
    							
    							//labelPos.x = labelPos.x * 1.1;
    							//labelPos.y = labelPos.y * 1.1;
    							
    							ctx.beginPath();
    							
    							ctx.arc(vm.x, vm.y, vm.outerRadius, sA, eA);
    							ctx.arc(vm.x, vm.y, vm.innerRadius, eA, sA, true);
    							
    							ctx.closePath();
    							ctx.strokeStyle = vm.borderColor;
    							ctx.lineWidth = vm.borderWidth;
    							
    							ctx.fillStyle = vm.backgroundColor;
    							
    							ctx.fill();
    							ctx.lineJoin = 'bevel';
    							
    							if (vm.borderWidth) {
    								ctx.stroke();
    							}
    							
    							if (vm.circumference > 0.6) { // Trying to hide label when it doesn't fit in segment
    								ctx.beginPath();
    								ctx.font = helpers.fontString(opts.defaultFontSize, opts.defaultFontStyle, opts.defaultFontFamily);
    								ctx.fillStyle = "#818181";
    								ctx.textBaseline = "center";
    								ctx.textAlign = "center";
    		            
    		            // Round percentage in a way that it always adds up to 100%
    								ctx.fillText(segmentLabel.toFixed(2) + "%", labelPos.x, labelPos.y);
    							

    		          }
    		          //display in the center the total sum of all segments
    		        /*   var total = dataset.data.reduce((sum, val) => sum + val, 0);
    		          ctx.fillText('Total = ' + total, vm.x, vm.y-20, 200); */
    		      }
    		    });

    		    var model = arc._model;
    		    model.backgroundColor = custom.backgroundColor ? custom.backgroundColor : valueAtIndexOrDefault(dataset.backgroundColor, index, arcOpts.backgroundColor);
    		    model.hoverBackgroundColor = custom.hoverBackgroundColor ? custom.hoverBackgroundColor : valueAtIndexOrDefault(dataset.hoverBackgroundColor, index, arcOpts.hoverBackgroundColor);
    		    model.borderWidth = custom.borderWidth ? custom.borderWidth : valueAtIndexOrDefault(dataset.borderWidth, index, arcOpts.borderWidth);
    		    model.borderColor = custom.borderColor ? custom.borderColor : valueAtIndexOrDefault(dataset.borderColor, index, arcOpts.borderColor);

    		    // Set correct angles if not resetting
    		    if (!reset || !animationOpts.animateRotate) {
    		      if (index === 0) {
    		        model.startAngle = opts.rotation;
    		      } else {
    		        model.startAngle = _this.getMeta().data[index - 1]._model.endAngle;
    		      }

    		      model.endAngle = model.startAngle + model.circumference;
    		    }

    		    arc.pivot();
    		  }
    		});

    		