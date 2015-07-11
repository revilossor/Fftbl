package core.world.parallax;
import flixel.group.FlxTypedGroup;

/**
 * ...
 * @author Oliver Ross
 */
class ParallaxBackground extends FlxTypedGroup<ParallaxLayer>
{
	private static inline var FOCAL_LENGTH:Float = 1000;
	
	public function new()
	{
		super();
		addLayer('assets/images/background/skyclouds.png', 900);
		addLayer('assets/images/background/buildings-3.png', 700);
		addLayer('assets/images/background/buildings-2.png', 600);
		addLayer('assets/images/background/buildings.png', 500);
	}
	
	function addLayer(imagePath:String, depth:Float):Void {
		add(new ParallaxLayer(imagePath, getScrollFactor(depth)));
	}
	function getScrollFactor(depth:Float):Float {
		return FOCAL_LENGTH / (FOCAL_LENGTH + depth);
	}
}