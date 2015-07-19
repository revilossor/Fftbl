package core.entity;
import flixel.FlxG;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.Material;
import nape.shape.Polygon;

/**
 * ...
 * @author Oliver Ross
 */
class PhysicsEntity extends PoolableEntity
{
	public var body:Body = new Body();
	
	var _bodyMaxSpeed:Float;
	var _forward:Vec2 = Vec2.get();
	
	public function new(?xp:Float = 0, ?yp:Float = 0, ?speed:Float = 1000) {
		super(xp, yp);
		_bodyMaxSpeed = speed;
	}
	
	//TODO collision callbacks
	
	
	override public function update() {
		body.applyImpulse(Vec2.weak(_forward.x * FlxG.elapsed, _forward.y * FlxG.elapsed));
		body.velocity.muleq(0.9);
		trackBodyPosition();
		super.update(); 
	}
	
	function trackBodyPosition() {
		if (body == null) { return; }
		x = body.position.x - width / 2;
		y = body.position.y - height / 2;
		angle = (body.rotation * 180) / Math.PI;
	}
	
	override public function destroy() {
		body = null;
		super.destroy();
	}
	
	function makeBoxBody(material:Material) {
		body.shapes.add(new Polygon(Polygon.box(width, height, true), material));
		body.position.setxy(x + width / 2, y + height / 2);
	}
	function makeCircleBody(material:Material) {
		body.shapes.add(new Polygon(Polygon.regular(width / 2, height / 2, 32, 0.0, true), material));
		body.position.setxy(x + width / 2, y + height / 2);
	}
	
	public function move(by:Vec2) {
		_forward = _forward.add(by);
		if(_forward.length > _bodyMaxSpeed) {
			_forward.length = _bodyMaxSpeed;
		}
	}
	
	public function dodge(impulse:Vec2) {
		body.velocity.setxy(0, 0);
		body.applyImpulse(impulse);
	}
}