package core.world;
import core.world.types.BinTree;
import core.world.types.Section;
import flixel.FlxBasic;

/**
 * ...
 * @author Oliver Ross
 */
class World extends FlxBasic
{
	var _nodes:Array<Section> = [];
	var _map:BinTree<Section>;
	var _depth:UInt;
	
	public function new() 
	{
		trace('construct');
		super();
		_nodes = getSections();
		_depth = getMaxDepth(_nodes.length);		
		_map = build(getMaxDepth(_nodes.length));
	}
	
	function getSections():Array<Section> {
		var sections:Array<Section> = [];
		for (i in 1...11) {		// TODO dunno where this will come from... loaded xml?
			sections.push({
				boss:new Boss(),
				route:new Route()
			});
		}
		return sections;
	}
	function getMaxDepth(total:UInt, ?index:UInt = 1):UInt {
		return (total > index) ? getMaxDepth(total - index++, index): index;
	}
	function build(remainingDepth:UInt, ?index:Int = 0):BinTree<Section> {		// BUG sometimes there can be a node where value is undefined ( or null if value isnt object ). Handle accordingly.
		if (index > _nodes.length) { return null; }
		var depth:UInt = _depth - remainingDepth;
		return {
			value:	_nodes[index],	// TODO init section here, so dont need _nodes array
			left:	remainingDepth == 0 ? null : build(remainingDepth - 1, index + depth + 1),
			right:	remainingDepth == 0 ? null : build(remainingDepth - 1, index + depth + 2)
		}
	}
	
	override public function destroy() {
		_map = null;
		super.destroy();
	}
}