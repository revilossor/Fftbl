package entities;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;

/**
 * ...
 * @author Oliver Ross
 */
class Path extends FlxGroup
{
	var lineStyle = { color: FlxColor.RED, thickness: 1 };
	var fillStyle = { color: FlxColor.RED, alpha: 0.5 };
	var canvas = new FlxSprite();
	
	public function new() 
	{
		super();
		initCanvas();
		//canvas.drawLine(0, 0, 100, 100, lineStyle);
	}
	
	function initCanvas() {
		canvas.makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
		add(canvas);
	}
	
}
/*
var lineDrawing:MovieClip;

var Spline_Points:Array = new Array();
var Spline_Lengths:Array = new Array();

var Interpolation_Points:Array = new Array(new Point(100,100),new Point(50,200),new Point(450,250),new Point(100,300));

//CATMULL ROM FUNCTIONALITY
function calculate_catmull(t:Number, p0:Number, p1:Number, p2:Number, p3:Number):Array{
    var t2:Number = t*t;
    var t3:Number = t2 * t;
    // P(t)
    var firstn:Number = (0.5 *( (2 * p1) + (-p0 + p2) * t +(2*p0 - 5*p1 + 4*p2 - p3) * t2 +(-p0 + 3*p1- 3*p2 + p3) * t3));
    // P'(t)
    var secondn:Number = 0.5 * (-p0 + p2) + t * (2*p0 - 5*p1 + 4*p2 - p3) + t2 * 1.5 * (-p0 + 3*p1 - 3*p2 + p3);
    // P''(t)
    var thirdn:Number = (2*p0 - 5*p1 + 4*p2 - p3) + t * 3.0 * (-p0 + 3*p1 - 3*p2 + p3);

    var arr:Array = new Array(firstn, secondn, thirdn);
    return arr;
}
//END CATMULL ROM FUNCTIONALITY
function draw_anchors():void{
    for(var k:Number = 0; k < Interpolation_Points.length; k++){ //loop through all the interpolation points, and render anchors
        var marker:Ball = new Ball();
        marker.x = Interpolation_Points[k].x;
        marker.y = Interpolation_Points[k].y;
        marker.scaleX = 0.5;
        marker.scaleY = 0.5;
        marker.id = k;
        marker.addEventListener(MouseEvent.MOUSE_DOWN,start_dragging);
        marker.addEventListener(MouseEvent.MOUSE_UP,stop_dragging);
        addChild(marker);
    }
}
function start_dragging(event:MouseEvent):void{
    event.target.addEventListener(MouseEvent.MOUSE_MOVE, update_dragging);
    event.target.startDrag();
}
function stop_dragging(event:MouseEvent):void{
    event.target.removeEventListener(MouseEvent.MOUSE_MOVE, update_dragging);
    event.target.stopDrag();
}

function update_dragging(event:MouseEvent):void{
    Interpolation_Points[event.target.id].x = event.target.x;
    Interpolation_Points[event.target.id].y = event.target.y;
    lineDrawing.graphics.clear();
    lineDrawing = new MovieClip();
    Spline_Points = new Array();
    init_track();
}
function init_track():void{
    
    for(var k:Number = 0; k < Interpolation_Points.length; k++){ //loop through all the interpolation points, and build splines in between
        
        var point0:Point = Interpolation_Points[k];
        var point1:Point = Interpolation_Points[(k+1) % Interpolation_Points.length];
        var point2:Point = Interpolation_Points[(k+2) % Interpolation_Points.length];
        var point3:Point = Interpolation_Points[(k+3) % Interpolation_Points.length];

        for(var g:Number = 0.0; g < 1.0; g += 0.005){ //for each segment, calculate 200 spine points and store onto vector
            
            var setX:Array = calculate_catmull(g, point0.x, point1.x, point2.x, point3.x);
            var setY:Array = calculate_catmull(g, point0.y, point1.y, point2.y, point3.y);

            // .x/.y/.z labelled incorrectly
            var spline_spot:Point = new Point(setX[0],setY[0]);
            var spline_spot_first:Point = new Point(setX[1],setY[1]);
            var spline_spot_second:Point = new Point(setX[2],setY[2]);
            //end incorrect labelling


            Spline_Points.push(spline_spot);
        }
    }
    
    lineDrawing = new MovieClip();
    this.addChild(lineDrawing);
    
    lineDrawing.graphics.lineStyle(1,0xFFFF00);
    lineDrawing.graphics.moveTo(Spline_Points[0].x,Spline_Points[0].y); ///This is where we start drawing
    for(var iter:Number = 1; iter < Spline_Points.length; iter++){
        lineDrawing.graphics.lineTo(Spline_Points[iter].x, Spline_Points[iter].y);
    }
    
    var filtersArray:Array = new Array();
    var color_array:Array = new Array(0xFF0000, 0x00FF00, 0x0000FF);
    for(var j:int = 0; j < color_array.length; j++){
        var dropShadow:DropShadowFilter = new DropShadowFilter();
        dropShadow.color = color_array[j];
        dropShadow.blurX = 1;
        dropShadow.blurY = 1;
        dropShadow.angle = 0;
        dropShadow.alpha = 1;
        dropShadow.distance = 4;
        filtersArray.push(dropShadow);
    }
    setChildIndex(lineDrawing,0);
    
    lineDrawing.filters = filtersArray;
}
draw_anchors();
init_track();
*/