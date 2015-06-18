package core.util;

/**
 * ...
 * @author Oliver Ross
 */
class MathUtil
{
	public static inline function nround(value:Int, n:Int):Int {		
		return Math.round(value / n) * n;
	}
}