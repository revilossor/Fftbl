package core.ui;
using flixel.util.FlxSpriteUtil;
import core.ui.player.PlayerHudWaypoint;
import core.util.TypedPool;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Oliver Ross
 */
class Canvas extends FlxGroup
{
	var _lineStyle:LineStyle = { color: FlxColor.RED, thickness: 20 };
	var _fillStyle:FillStyle = { color: FlxColor.RED, alpha: 0.5 };

	var _canvas = new FlxSprite();
	var _pathNodes:Array<FlxPoint> = new Array<FlxPoint>();	// TODO make Path class so can have multiple paths....
	
	public function new() 
	{
		super();
		add(_canvas);
	}
	public function init(width, height) {
		_canvas.makeGraphic(width, height, FlxColor.TRANSPARENT, true);	
	}
	
	public function drawSpline(points:Array<FlxPoint>) {
		for (i in 0...points.length - 1) {
			var p0:FlxPoint = points[(i -1 + points.length) % points.length];
            var p1:FlxPoint = points[i];
            var p2:FlxPoint = points[(i +1 + points.length) % points.length];
            var p3:FlxPoint = points[(i +2 + points.length) % points.length];
			var last:FlxPoint = p1;
			for (j in 0...11) {
				var q:FlxPoint = catmullRom(p0, p1, p2, p3, 0.1 * j);
				drawLine(last.x, last.y, q.x, q.y);
				last = q;
			}
		}
	}	
	public function drawLine(startX, startY, endX, endY) {
		_canvas.drawLine(startX, startY, endX, endY, _lineStyle);
	}
	public function cls() {
		_canvas.fill(FlxColor.TRANSPARENT);
	}
	
	function catmullRom(p0:FlxPoint, p1:FlxPoint, p2:FlxPoint, p3:FlxPoint, t:Float):FlxPoint {
		//http://www.mvps.org/directx/articles/catmull/
		return FlxPoint.weak(
			0.5 * ((2*p1.x) +
				t * ((-p0.x + p2.x) +
				t * ((2 * p0.x -5 * p1.x +4 * p2.x -p3.x) +
				t * (-p0.x +3 * p1.x -3 * p2.x +p3.x)))),
			0.5 * ((2 * p1.y) +
				t * (( -p0.y + p2.y) +
				t * ((2 * p0.y - 5 * p1.y + 4 * p2.y -p3.y) +
				t * ( -p0.y +3 * p1.y - 3 * p2.y +p3.y))))
		);
	}
	
	public function addPathNode(at:FlxPoint) {
		_pathNodes.push(at);
		cls();
		drawSpline(_pathNodes);
	}
	public function removeFirstPathNode() {
		_pathNodes[0].destroy();
		_pathNodes[0] = null;
		_pathNodes.splice(0, 1);
		cls();
		drawSpline(_pathNodes);
	}
	public function clearPath() {
		while (_pathNodes.length > 0) {
			removeFirstPathNode();
		}
	}
	
	override public function destroy() {
		trace('destroy');
		clearPath();
		_pathNodes = null;
		_canvas.destroy();
		_canvas = null;
		super.destroy();
	}
}