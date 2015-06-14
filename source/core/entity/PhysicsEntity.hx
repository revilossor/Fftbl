package core.entity;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Polygon;
import nape.shape.Shape;

/**
 * ...
 * @author Oliver Ross
 */
class PhysicsEntity extends PoolableEntity
{
	public var body:Body;
	
	public function new(?xp:Float = 0, ?yp:Float = 0) {
		super(xp, yp);
	}
	
	//TODO movement method, collision handling
	
	override public function update() {
		trackBodyPosition();
		super.update();
		//trackBodyPosition();
	}
	
	function trackBodyPosition() {
		if (body == null) { return; }
		x = body.position.x - width/2;	// TODO may be some anchor point bugs here
		y = body.position.y- height/2;
		angle = (body.rotation * 180) / Math.PI;
	}
	
	override public function destroy() {
		body = null;
		super.destroy();
	}
}