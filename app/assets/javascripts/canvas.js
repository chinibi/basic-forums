var canvas = $('#create-canvas')[0]
if (canvas.getContext) {
  var ctx = canvas.getContext('2d')
  ctx.fillStyle = 'white'
  ctx.rect(0,0,canvas.width-2,canvas.height-2)
  // puts a white background on the canvas.
  // putting a border around a box messes up the coordinates a bit. this
  // fudge factor of -2 allows the right and bottom borders to be visible
  // but the drawing can now appear to overflow out of those sides
  ctx.fill()
}
var mouseIsDown = false; // makes sure you draw by click and drag


// get coordinates of the cursor on the canvas while
// adjusting for the canvas element being offset from
// the origin.
function mousePos(e) {
  return {
    x: e.pageX - $(e.target).offset().left,
    y: e.pageY - $(e.target).offset().top
  }
}

$('#create-canvas').mousedown(function(event) {
  mouseIsDown = true;
  ctx.moveTo(mousePos(event).x, mousePos(event).y)
  ctx.beginPath()
})

$('#create-canvas').mousemove(function(event) {
  if (mouseIsDown) {
    ctx.lineTo(mousePos(event).x, mousePos(event).y)
    ctx.closePath()
    ctx.stroke()
    ctx.moveTo(mousePos(event).x, mousePos(event).y)
  }
})

$('#create-canvas').mouseup(function(event) {
  mouseIsDown = false
  $('.image-url').val(canvas.toDataURL("image/gif"))
})
