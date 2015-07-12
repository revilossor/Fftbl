package core.world.tiled;
import core.world.tiled.TiledMap;
import core.world.tiled.TiledTileSet;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxRect;
import haxe.io.Path;

/**
 * ...
 * @author Oliver Ross
 * 
 * 
 */
class TiledLevel extends TiledMap
{
	private inline static var c_PATH_LEVEL_TILESHEETS = "assets/images/";
	
	//private var collidableTileLayers:Array<FlxTilemap>;		// TODO physics?
	
	public var environment:FlxGroup;
	
	public function new(tiledLevel:Dynamic)
	{
		super(tiledLevel);
		
		environment = new FlxGroup();
		
		FlxG.camera.bounds = new FlxRect(0, 0, fullWidth, fullHeight);
		FlxG.worldBounds.set(0, 0, fullWidth, fullHeight);
		
		for (tileLayer in layers) {
			var tileSheetName:String = tileLayer.properties.get("tileset");
			if (tileSheetName == null) {
				trace("'tileset' property not defined for the '" + tileLayer.name + "' layer. Please add the property to the layer.");
			}
			var tileSet:TiledTileSet = null;
			for (ts in tilesets) {
				if (ts.name == tileSheetName) {
					tileSet = ts;
					break;
				}
			}
			if (tileSet == null) {
				trace("Tileset '" + tileSheetName + " not found. Did you mispell the 'tilesheet' property in " + tileLayer.name + "' layer?");
			}
			var imagePath = new Path(tileSet.imageSource);
			var processedPath = c_PATH_LEVEL_TILESHEETS + imagePath.file + "." + imagePath.ext;
			var tilemap:FlxTilemap = new FlxTilemap();
			tilemap.widthInTiles = width;
			tilemap.heightInTiles = height;
			
			tilemap.loadMap(tileLayer.tileArray, processedPath, tileSet.tileWidth, tileSet.tileHeight, 0, 1, 1, 1);
			environment.add(tilemap);
		/*	if (tileLayer.properties.contains("nocollide")) {
				backgroundTiles.add(tilemap);
			} else {
				if (collidableTileLayers == null) { collidableTileLayers = new Array<FlxTilemap>(); }
				foregroundTiles.add(tilemap);
				collidableTileLayers.push(tilemap);
			}*/
		}
		//initEntities(objectGroups);
		//Reg.entities = new EntityDelegate(objectGroups);
	}
/*	function initEntities(objectGroups:Array<TiledObjectGroup>) {
		for (group in objectGroups) {
			switch(group.name) {
				case 'hats' : Reg.hats = new HatDelegate(group);
				default : trace('ERROR dodnt recognise group ${group.name}');
			}
		}
	}*/
	/*public function collideWithLevel(obj:FlxObject, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool {
		if (collidableTileLayers != null) {
			for (map in collidableTileLayers) {
				if(FlxG.overlap(map, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate)) {
					return true;
				}
			}
		}
		return false;
	}*/
}