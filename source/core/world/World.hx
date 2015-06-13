package core.world;
import flixel.FlxBasic;

/**
 * ...
 * @author Oliver Ross
 */
@generic
class World<T> extends FlxBasic //TODO generic?
{
	var _nodes:Array<T> = [];
	var _map:BinTree<T>;
	
	var _maxDepth:Int = 4;
	
	public function new(sections:Array<T>) 
	{
		trace('construct');
		super();
		_nodes = sections;
		_map = build(_maxDepth, 0);
		trace('hww');
	}
	
	function build(remainingDepth:UInt, index:Int):BinTree<T> {		// BUG sometimes there can be a node where index can be null.
		if (index > _nodes.length) { return null; }
		var depth:UInt = _maxDepth - remainingDepth;
		return {
			value:	_nodes[index],
			left:	remainingDepth == 0 ? null : build(remainingDepth - 1, index + depth + 1),
			right:	remainingDepth == 0 ? null : build(remainingDepth - 1, index + depth + 2)
		}
	}
	
	override public function destroy() {
		_map = null;
		super.destroy();
	}
	
}