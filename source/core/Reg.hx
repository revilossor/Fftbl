package core;
import core.ui.HUD;
import core.util.BinTree;
import core.world.Section;
import core.world.World;
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
	public static var input:InputDelegate;
	public static var hud:HUD;
	
	public static var world:World;
	public static var sections:Array<Section> = [		// TODO parse this from loaded xml? and xml Tiled levels with string entity names to parse and instantiate at positions
		{intro:StadiumState,	route:StadiumExitState,		boss:StadiumGatesBossState,		index:0},
		{intro:IntroState,		route:RouteState, 			boss:BossState,					index:0},
		{intro:IntroState,		route:RouteState,			boss:BossState,					index:0}
	];
	public static var sectionTree:BinTree<Section>;		// TODO make progress object that can be serealised for game history in local storage
	public static var sectionStage:SectionStage;

	public static var isPaused:Bool = false;
}