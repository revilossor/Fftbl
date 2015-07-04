package core.model;
import haxe.Http;

/**
 * ...
 * @author Oliver Ross
 */
class ModelLoader
{
	public function new() {}
	public function get(uri, onModel) {	// TODO pass in timestamp?
		// TODO cache in / get from appropriate storage ( consider timestamp, online status )
		httpLoad(uri, function(data) {
			onModel(parse(data));
		});
		// TODO return async backup local cached copy
	}
	
	function httpLoad(from, onData) {
		var httpLoader = new Http(from);
		httpLoader.onData = onData;
		httpLoader.request(false);		// GET
	}
	
	function parse(data):Model {
		trace('parse $data');
		return new Model(data);
	}
}

/*import haxe.Http;
import haxe.xml.Fast;

class XmlParsRead {

    function new() {

        //asynchronous call 
        var resource_url = new haxe.Http("http://localhost:96/SCO1.2/imsmanifest.xml");

        // onData event method will catch the response data if request is success 
         resource_url.onData = function(resource_url) { 

              var xml = Xml.parse(resource_url);
              // to see the xml file
              //trace(xml);
              // enter into xml file 1st element 
              var xmlReadFirstElement = new Fast(xml.firstElement());
              // see the element name 
              trace(xmlReadFirstElement.name);
              // I want to go resources tag "'node' is predefine attribute it reprasent node(tag<some>) in xml file "
              var resesNode = xmlReadFirstElement.node.resources;
              // name is predefined attribute to see the tag name
              trace(resesNode.name);
              // I want to go resource(it is sub of resources tag )
              var res = resesNode.node.resource;
              // to see the resource tag name
              trace(res.name);
              // I've to read href attribute in <resource>tag i.e -<resource identifier="SCO_RES" adlcp:scormtype="sco" href="some.htm" type="webcontent"> ..</resource>
              var res_href = res.att.href;
              trace(res_href);
              // next read the list of sub tags( <file>) resource tag using loop
              // RES(res) is point the resource tag and NODES(nodes) is predefine attributes we can use to iterate list of sub tags or sub nodes 
              for (subtaghref in res.nodes.file) {
                  //<file href="some.htm"/>
                  trace(subtaghref.att.href);
              }
         }
        // making the asynchronous request 
         resource_url.request(false);
    }

    public static function main() {

        new XmlParsRead();
    }
}*/