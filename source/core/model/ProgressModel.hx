package core.model;

/**
 * ...
 * @author Oliver Ross
 */
class ProgressModel
{
	public var currentSegment:SectionStage;
	
	
	public function new() 
	{
		
	}
	
}
enum SectionStage {
	Intro;
	Route;
	Boss;
}