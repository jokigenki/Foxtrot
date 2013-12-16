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

class SoundLevels
{    
	static var levels:Map<String, Int> = new Map();
	static var initialised:Bool = false;
	
 	public function new()
	{
	}

	public static function init()
	{
		//	add sound levels in here, as follows:
		//	levels.set("SoundName", 100);
	}

	public static function getLevel(key:String):Int
	{
		if (!SoundLevels.initialised)
		{
			SoundLevels.init();
			SoundLevels.initialised = true;
		}
		var level = SoundLevels.levels.get(key);
		if (level == null) return 100;

		return level;
	}
}