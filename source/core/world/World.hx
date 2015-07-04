package core.world;
import core.util.BinTree;
import core.world.Section;
import flixel.FlxBasic;
import flixel.FlxState;
import Reg;
import states.menu.WinState;
import states.section.boss.BossState;

/**
 * ...
 * @author Oliver Ross
 */
class World extends FlxBasic
{
	var _map:BinTree<Section>;
	var _depth:UInt;
	
	public function new() 
	{
		trace('construct');
		super();
		_depth = getMaxDepth(Reg.sections.length);
		Reg.sectionTree = _map = build(_depth);
	}
	
	function getMaxDepth(total:UInt, ?index:UInt = 1):UInt {
		return (total >= index) ? getMaxDepth(total - index++, index): index;
	}
	function build(remainingDepth:UInt, ?index:Int = 0):BinTree<Section> {
		if (index >= Reg.sections.length) { return null; }
		var depth:UInt = _depth - remainingDepth;
		return {
			value:	{intro:Reg.sections[index].intro, route:Reg.sections[index].route, boss:Reg.sections[index].boss, index:index},
			left:	remainingDepth == 0 ? null : build(remainingDepth - 1, index + depth + 1),
			right:	remainingDepth == 0 ? null : build(remainingDepth - 1, index + depth + 2)
		}
	}
	
	public function getCurrentIntro():Class<FlxState> { 
		return Reg.sectionTree.value.intro == null ?
					WinState:
					Reg.sectionTree.value.intro;
	}
	public function getNext(?direction:BossResolution):Class<FlxState> {
		trace('get next - currently at node ${Reg.sectionTree.value.index} in stage ${Reg.sectionStage}');
		switch(Reg.sectionStage) {
			case SectionStage.Intro	:
				Reg.sectionStage = SectionStage.Route;
				return Reg.sectionTree.value.route;
			case SectionStage.Route	:
				Reg.sectionStage = SectionStage.Boss;
				return Reg.sectionTree.value.boss;
			case SectionStage.Boss	:
				Reg.sectionStage = SectionStage.Intro;
				if (direction == BossResolution.Right) {
					var tree = Reg.sectionTree.right;
					tree == null ? return WinState : Reg.sectionTree = tree;
					return getCurrentIntro();
				}else if (direction == BossResolution.Left) {
					var tree = Reg.sectionTree.left;
					tree == null ? return WinState : Reg.sectionTree = tree;
					return getCurrentIntro();
				}else {
					trace('ERROR! tried to getNext when on boss stage, and didnt pass a resolution!');
					return getCurrentIntro();
				}
			default : trace('ERROR! tried to getNext but Reg.sectionStage wasnt recognised!');
		}
		return getCurrentIntro();
	}
	
	override public function destroy() {
		 _map = null;
		super.destroy();
	}
}
enum SectionStage {
	Intro;
	Route;
	Boss;
}