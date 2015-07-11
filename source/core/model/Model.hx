package core.model;
import core.world.World;

/**
 * ...
 * @author Oliver Ross
 */
class Model
{
	public var world:World;
	public var settings:SettingsModel;
	public var progress:ProgressModel;
	
	public function new(data) 
	{
		trace('construct model with $data');
		world = new World();
		settings = new SettingsModel();		// TODO construct from data
		progress = new ProgressModel();
	}

	public function test() {
		trace('hello model');
	}
	
}