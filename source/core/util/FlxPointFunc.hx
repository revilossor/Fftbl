package core.util;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Oliver Ross TODO - static extention of flxpoint?
 */
class FlxPointFunc
{
	public static function add(a:FlxPoint, b:FlxPoint):FlxPoint {
		return FlxPoint.weak(a.x + b.x, a.y + b.y);
	}
	public static function sub(a:FlxPoint, b:FlxPoint):FlxPoint {
		return FlxPoint.weak(a.x - b.x, a.y - b.y);
	}
	public static function div(a:FlxPoint, b:FlxPoint):FlxPoint {
		return FlxPoint.weak(a.x / b.x, a.y / b.y);
	}
	public static function mul(a:FlxPoint, b:FlxPoint):FlxPoint {
		return FlxPoint.weak(a.x * b.x, a.y * b.y);
	}
	public static function getBetween(a:FlxPoint, b:FlxPoint):FlxPoint {
		return FlxPoint.weak(b.x - a.x, b.y - a.y);
	}
	public static function getUnitBetween(a:FlxPoint, b:FlxPoint):FlxPoint {
		return normalise(getBetween(a, b));
	}
	public static function getDistanceBetween(a:FlxPoint, b:FlxPoint):Float {
		return getMagnitude(getBetween(a, b)); 
	}
	public static function distanceCheck(a:FlxPoint, b:FlxPoint, threshold:Float):Bool {
		return getMagnitudeSq(getBetween(a, b)) <= (threshold * threshold)?true:false;
	}
	public static function getMagnitude(v:FlxPoint):Float {
		return Math.sqrt(Math.pow(v.x, 2) + Math.pow(v.y, 2));
	}
	public static function getMagnitudeSq(v:FlxPoint):Float {
		return Math.pow(v.x, 2) + Math.pow(v.y, 2);
	}
	public static function normalise(v:FlxPoint):FlxPoint {
		var mag:Float = getMagnitude(v);
		return FlxPoint.weak(v.x / mag, v.y / mag);
	}
	public static function magnify(v:FlxPoint, m:Float):FlxPoint {
		return FlxPoint.weak(v.x * m, v.y * m);
	}
	public static function setMagnitude(v:FlxPoint, m:Float):FlxPoint {
		return magnify(normalise(v), m);
	}
	public static function getNormals(a:FlxPoint):Array<FlxPoint> {
		var ret:Array<FlxPoint> = new Array<FlxPoint>();
		ret.push(FlxPoint.weak( -a.y, a.x));
		ret.push(FlxPoint.weak(a.y, -a.x));
		return ret;
	}
	public static function dot(a:FlxPoint, b:FlxPoint):Float {
		return (a.x * b.x) + (a.y * b.y);
	}
}