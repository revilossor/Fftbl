package core;
import core.nape.PhysicsSimulation;
import core.world.types.BinTree;
import core.world.types.Section;
import core.world.World;
import nape.space.Space;
import states.section.boss.BossState;
import states.section.boss.StadiumGatesBossState;
import states.section.intro.IntroState;
import states.section.intro.StadiumState;
import states.section.route.RouteState;
import states.section.route.StadiumExitState;

/**
 * ...
 * @author Oliver Ross
 */
class Reg
{
	public static var world:World;
	public static var sections:Array<Section> = [		// TODO parse this from loaded xml? and xml Tiled levels with string entity names to parse and instantiate at positions
		{intro:StadiumState,	route:StadiumExitState,		boss:StadiumGatesBossState,		index:0},
		{intro:IntroState,		route:RouteState, 			boss:BossState,					index:0},
		{intro:IntroState,		route:RouteState,			boss:BossState,					index:0}
	];
	public static var sectionTree:BinTree<Section>;		// TODO make progress object that can be serealised for game history in local storage
	public static var sectionStage:SectionStage;
}
enum SectionStage {	// TODO move to section
	Intro;
	Route;
	Boss;
}
enum BossResolution {	// TODO move to BossState
	Left;
	Right;
}