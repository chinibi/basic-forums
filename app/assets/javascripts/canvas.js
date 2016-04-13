var canvas = $('#create-canvas')[0]
if (canvas.getContext) {
  var ctx = canvas.getContext('2d')
}
var mouseIsDown = false;

function mousePos(e) {
  return {
    x: e.pageX - $(e.target).offset().left,
    y: e.pageY - $(e.target).offset().top
  }
}

$('#create-canvas').mousedown(function() {
  mouseIsDown = true;
  ctx.moveTo(mousePos(event).x, mousePos(event).y)
  ctx.beginPath()
})

$('#create-canvas').mousemove(function() {
  if (mouseIsDown) {
    ctx.lineTo(mousePos(event).x, mousePos(event).y)
    ctx.closePath()
    ctx.stroke()
    ctx.moveTo(mousePos(event).x, mousePos(event).y)
  }
})

$('#create-canvas').mouseup(function() {
  mouseIsDown = false
  console.log(canvas.toDataURL("image/gif"))
})

$('#create-canvas').mouseleave(function() {
  mouseIsDown = false
  console.log(canvas.toDataURL("image/gif"))
})
