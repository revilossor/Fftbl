package core;
import core.world.types.BinTree;
import core.world.types.Section;
import core.world.World;
import states.section.boss.BossState;
import states.section.intro.IntroState;
import states.section.route.RouteState;

/**
 * ...
 * @author Oliver Ross
 */
class Reg
{
	public static var world:World;
	public static var sections:Array<Section> = [		// TODO parse this from loaded xml?
		{intro:IntroState, route:RouteState, boss:BossState, index:0},
		{intro:IntroState, route:RouteState, boss:BossState, index:0},
		{intro:IntroState, route:RouteState, boss:BossState, index:0}
	];
	public static var sectionTree:BinTree<Section>;
	public static var sectionStage:SectionStage = SectionStage.Intro;
}
enum SectionStage {
	Intro;
	Route;
	Boss;
}
enum BossResolution {
	Left;
	Right;
}