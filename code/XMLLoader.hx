/*
    Stencyl exclusively uses the Haxe programming language. 
    Haxe is similar to ActionScript and JavaScript.
    
    Want to use native code or make something reusable? Use the Extensions Framework instead.
    http://www.stencyl.com/help/view/engine-extensions/
    
    Learn more about Haxe and our APIs
    http://www.stencyl.com/help/view/haxe/
*/

package scripts;

import com.stencyl.Engine;

class XMLLoader
{    
	var someNumber:Int;
	var someText:String;

 	public function new(path:String, event:)
	{
	}

	private function getXMLDesktopString(path:String):String
	{
        var nativeUserDir:String = nme.filesystem.File.userDirectory.nativePath;
        var fullPath = nativeUserDir + path;

        var xmlString:String = sys.io.File.getContent(fullPath);
        return xmlString;
    }
}