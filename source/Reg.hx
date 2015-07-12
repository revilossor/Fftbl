package;
import core.InputDelegate;
import core.model.Model;
import core.ui.HUD;
import core.world.Section;
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
	public static inline var modelURI:String = 'http://revilossor.github.io/Fftbl/www/model/model.xml';
	
	public static var input:InputDelegate;
	public static var hud:HUD;
	public static var model:Model;
	
	public static var sections:Array<Section> = [		// TODO parse this from loaded xml? and xml Tiled levels with string entity names to parse and instantiate at positions
		{intro:StadiumState,	route:StadiumExitState,		boss:StadiumGatesBossState,		index:0},		// Guess all these will be the same class - with model data in tilemap.
		{intro:IntroState,		route:RouteState, 			boss:BossState,					index:0},
		{intro:IntroState,		route:RouteState,			boss:BossState,					index:0}
	];
}