package core.util;
import nape.geom.Vec2;

/**
 * ...
 * @author Oliver Ross TODO - static extention
 */
class Vec2Func {
	
	public static function add(a:Vec2, b:Vec2) {
		return Vec2.weak(a.x + b.x, a.y + b.y);
	}
	public static function sub(a:Vec2, b:Vec2):Vec2 {
		return Vec2.weak(a.x - b.x, a.y - b.y);
	}
	public static function div(a:Vec2, b:Vec2):Vec2 {
		return Vec2.weak(a.x / b.x, a.y / b.y);
	}
	public static function mul(a:Vec2, b:Vec2):Vec2 {
		return Vec2.weak(a.x * b.x, a.y * b.y);
	}
	public static function getBetween(a:Vec2, b:Vec2):Vec2 {
		return Vec2.weak(b.x - a.x, b.y - a.y);
	}
	public static function getUnitBetween(a:Vec2, b:Vec2):Vec2 {
		return normalise(getBetween(a, b));
	}
	public static function getDistanceBetween(a:Vec2, b:Vec2):Float {
		return getMagnitude(getBetween(a, b)); 
	}
	public static function distanceCheck(a:Vec2, b:Vec2, threshold:Float):Bool {
		return getMagnitudeSq(getBetween(a, b)) <= (threshold * threshold)?true:false;
	}
	public static function getMagnitude(v:Vec2):Float {
		return Math.sqrt(Math.pow(v.x, 2) + Math.pow(v.y, 2));
	}
	public static function getMagnitudeSq(v:Vec2):Float {
		return Math.pow(v.x, 2) + Math.pow(v.y, 2);
	}
	public static function normalise(v:Vec2):Vec2 {
		var mag:Float = getMagnitude(v);
		return Vec2.weak(v.x / mag, v.y / mag);
	}
	public static function magnify(v:Vec2, m:Float):Vec2 {
		return Vec2.weak(v.x * m, v.y * m);
	}
	public static function setMagnitude(v:Vec2, m:Float):Vec2 {
		return magnify(normalise(v), m);
	}
	public static function getNormals(a:Vec2):Array<Vec2> {
		var ret:Array<Vec2> = new Array<Vec2>();
		ret.push(Vec2.weak( -a.y, a.x));
		ret.push(Vec2.weak(a.y, -a.x));
		return ret;
	}
	public static function dot(a:Vec2, b:Vec2):Float {
		return (a.x * b.x) + (a.y * b.y);
	}
}