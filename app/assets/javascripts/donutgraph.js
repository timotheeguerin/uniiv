function loadDonuts(){
  $(".donut").each(function(i, obj)
  {
    var id = $(this).attr("id");
    var canvasid = id + "_canvas";
    $(this).html("<canvas id='" + canvasid + "' width='150px' height='150px'></canvas");
    var percentage1 = $(this).attr("data-pc-1");
    var percentage2 = $(this).attr("data-pc-2");
    if(percentage1 === undefined || percentage1 == " ")
    {
      percentage1 = 0;
    }
    if(percentage2 === undefined || percentage2 == " ")
    {
      percentage2 = 0;
    }
    graphDonut(percentage1,percentage2,canvasid);
  });
}

function graphDonut(percentage1,percentage2,id)
{
  if(percentage1 == 0 && percentage2 == 0)
  {
    graphDonutTwo(percentage1,percentage2,id);
  }else if(percentage2 == 0)
  {
    graphDonutOne(percentage1,id);
  }else if(percentage1 == 0)
  {
    graphDonutOneYellow(percentage2,id);
  }else{
    graphDonutTwo(percentage1,percentage2,id);
  }
}

function graphDonutOne(percentage,id)
{
    donutone(75,75,75,12,percentage,0,id);
}


function graphDonutOneYellow(percentage,id)
{
    donutoneyellow(75,75,75,12,percentage,0,id);
}

function graphDonutTwo(percentage1,percentage2,id)
{
    donuttwo(75,75,75,12,percentage1,percentage2,0,id);
}

function donutone(x, y, radius, thickness, percentage, offset, id) {
    var canvas = document.getElementById(id);
    drawDonut(x, y, radius, thickness, 1, offset, canvas, "#f5f5f5");
    drawDonut(x, y, radius, thickness, percentage/100, offset, canvas, "#274d9b");
    drawText(x+5,y+10,percentage + "%",canvas);
}

function donutoneyellow(x,y,radius,thickness,percentage,offset,id){
    var canvas = document.getElementById(id);
    drawDonut(x, y, radius, thickness, 1, offset, canvas, "#f5f5f5");
    drawDonut(x, y, radius, thickness, percentage/100, offset, canvas, "#E8A627");
    drawText(x+5,y+10,percentage + "%",canvas);
}

function donuttwo(x,y,radius,thickness,percentage1,percentage2,offset,id){
    var canvas = document.getElementById(id);
    drawDonut(x, y, radius, thickness, 1, offset, canvas, "#f5f5f5");
    drawDonut(x, y, radius, thickness, percentage1/100, offset, canvas, "#274d9b");
    drawText(x+5,y-5,percentage1 + "%",canvas);
    drawDonut(x, y, radius, thickness, percentage2/100, offset+percentage1, canvas, "#E8A627");
    drawText(x+5,y+25,percentage2 + "%",canvas);
}

function drawDonut(x, y, radius, thickness, percentage, offset, canvas, color) {
    offset = offset - 0.25;
    var context = canvas.getContext('2d');
    var startAngle = 0 + (2 * offset * Math.PI);
    var endAngle = 2 * Math.PI * percentage + (offset * Math.PI * 2);

    context.beginPath();
    var point = getPoint(x, y, radius, startAngle);
    var ipoint = getPoint(x, y, radius - thickness, startAngle);
    context.moveTo(ipoint[0], ipoint[1]);
    context.lineTo(point[0], point[1]);
    context.arc(x, y, radius, startAngle, endAngle, 0);
    point = getPoint(x, y, radius, endAngle);
    ipoint = getPoint(x, y, radius - thickness, endAngle);
    context.moveTo(point[0], point[1]);
    context.lineTo(ipoint[0], ipoint[1]);
    context.arc(x, y, radius - thickness, endAngle, startAngle, 1);
    context.fillStyle = color;
    context.fill();
}

function getPoint(x, y, radius, angle) {
    return [x + radius * Math.cos(angle), y + radius * Math.sin(angle)];
}

function drawText(x, y, text, canvas) {
    var context = canvas.getContext('2d');
    context.font = "lighter 30px sans-serif";
    context.textAlign = 'center';
    context.fillText(text, x, y);
}