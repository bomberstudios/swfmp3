/**
* 
* Delegate Class, MTASC compatible
* Ale Muñoz <ale@bomberstudios.com>
* 2007-08-09
* 
**/

class com.bomberstudios.utils.Delegate {
  // from Till Schneidereit
  // http://lists.motion-twin.com/pipermail/mtasc/2005-April/001602.html
  public static function create(scope:Object,method:Function):Function{
    var params:Array = arguments.splice(2,arguments.length-2);
    var proxyFunc:Function = function():Void{
      method.apply(scope,arguments.concat(params));
    }
    return proxyFunc;
  }
  public static function createR(scope:Object,method:Function):Function{
    var params:Array = arguments.splice(2,arguments.length-2);
    var proxyFunc:Function = function():Void{
      method.apply(scope,params.concat(arguments));
    }
    return proxyFunc;
  }
}